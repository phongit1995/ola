import type { MotionKind } from './FarmTownMotion.types';
import { CROP_CLIPS, DURATION } from './FarmTownMotion.constants';
import { Animation, AnimationClip, AnimationState, animation, Node, Vec3 } from 'cc';
let sharedCropClips: AnimationClip[] | undefined;

/** Crop clips are shared by every instance; only the states are per node. */
function cropClips(): AnimationClip[] {
  if (sharedCropClips) return sharedCropClips;
  sharedCropClips = CROP_CLIPS.map(([name, amount]) => {
    const clip = new AnimationClip(`crop-${name}`);
    clip.duration = DURATION;
    clip.enableTrsBlending = false;
    const track = new animation.VectorTrack();
    track.componentsCount = 3;
    track.path = new animation.TrackPath().toProperty('scale');
    track
      .channels()
      .forEach(({ curve }, axis) =>
        curve.assignSorted(
          [0, 0.5, 1, 1.5, 2].map(
            (time, i) =>
              [time, { value: axis === 2 ? 1 : 1 + [0, amount, 0, -amount, 0][i] * (axis === 0 ? -0.5 : 1) }] as [
                number,
                { value: number },
              ]
          )
        )
      );
    clip.addTrack(track);
    return clip;
  });
  return sharedCropClips;
}

/** Crops keep their existing clips. Farm Town parts use local presentation time to articulate the source pose.
 * These motions do not replay the source Unity Animator curves or change production timers.
 */
export class FarmTownMotion {
  private states = new Map<string, AnimationState>();
  private parts: { node: Node; position: Vec3; angle: number; role: string; phase: number }[] = [];
  constructor(
    node: Node,
    private kind: MotionKind,
    private species = ''
  ) {
    if (kind !== 'crop') {
      for (const part of node.getChildByName('Model')?.children ?? []) {
        const n = part.name;
        const role =
          kind === 'animal'
            ? /^(sheya|chub|boroda|gl[_-]|kluv|rot|nos|r_m|n_[pl]|golova|uho|visulk|greben|zub|morda|sheka|pyatak|sherst_golova)/.test(
                n
              )
              ? 'head'
              : /^(hv|krylo)/.test(n)
                ? 'tail'
                : /^(stopa|koleno|kop|lokot|lap|pyatka|bedro|pleche|kist)/.test(n)
                  ? 'leg'
                  : ''
            : /koleso|meshalo|mixer/.test(n)
              ? 'wheel'
              : /loom_(pereklad|ogloblya|nitki)|molotilka|skalka/.test(n)
                ? 'shuttle'
                : /moloko|ogon|ugol|testo|pop_[1-6]|napoln|kotleta|krishka_2/.test(n)
                  ? 'pulse'
                  : '';
        if (role)
          this.parts.push({
            node: part,
            position: part.position.clone(),
            angle: part.angle,
            role,
            phase: part.position.x < 0 ? 0 : Math.PI,
          });
      }
      return;
    }
    const component = node.addComponent(Animation);
    for (const clip of cropClips()) this.states.set(clip.name.slice('crop-'.length), component.createState(clip));
  }
  sample(name: string, time: number, enabled: boolean, walking = false): void {
    if (this.kind !== 'crop') {
      const t = enabled ? time : 0,
        active = enabled && name === 'working';
      for (const p of this.parts) {
        let x = 0,
          y = 0,
          angle = p.angle;
        if (this.kind === 'animal' && enabled) {
          if (p.role === 'head') {
            const peck = this.species === 'layer';
            y = active
              ? -(peck ? 0.12 : 0.055) * (0.5 + 0.5 * Math.sin(t * (peck ? 5 : 2.6)))
              : Math.sin(t * 1.4) * 0.012;
            x = active ? -y * 0.25 : 0;
          } else if (p.role === 'tail') y = Math.sin(t * 3.2) * 0.035;
          else if (p.role === 'leg' && walking) {
            x = Math.sin(t * 7 + p.phase) * 0.024;
            y = Math.max(0, Math.cos(t * 7 + p.phase)) * 0.025;
          }
        } else if (active) {
          if (p.role === 'wheel') angle += (t * 65) % 360;
          else if (p.role === 'shuttle') x = Math.sin(t * 4) * 0.065;
          else if (p.role === 'pulse') y = Math.sin(t * 5 + p.phase) * 0.022;
        }
        p.node.setPosition(p.position.x + x, p.position.y + y, p.position.z);
        p.node.angle = angle;
      }
      return;
    }
    const state = this.states.get(name);
    if (!state) throw Error('Không có chuyển động ' + name);
    state.time = enabled ? time % DURATION : 0;
    state.sample();
  }
}
