import { THEME } from './AudioService.constants';
import { AudioClip, AudioSource, Node } from 'cc';
import { Art } from '../../render/Art';
import { GameSession } from '../../core/GameSession';

/** Background music and one-shot effects, gated by the player's settings and the session state. */
export class AudioService {
  private music: AudioSource;
  private effects: AudioSource;

  constructor(
    host: Node,
    private art: Art,
    private session: GameSession
  ) {
    this.music = host.addComponent(AudioSource);
    this.effects = host.addComponent(AudioSource);
    this.music.loop = true;
    this.music.volume = session.runtime.audio.musicVolume;
    this.effects.volume = session.runtime.audio.effectVolume;
    const theme = art.audio.get(THEME);
    if (theme) this.music.clip = theme;
  }

  get playing(): boolean {
    return this.music.playing;
  }

  clip(name: string): AudioClip | undefined {
    return this.art.audio.get(`assets/audio/${name}.wav`);
  }

  sfx(name = 'Click 1'): void {
    this.startMusic();
    if (!this.session.settings.sound) return;
    const clip = this.clip(name);
    if (clip) this.effects.playOneShot(clip, this.session.runtime.audio.effectVolume);
  }

  startMusic(): void {
    const { settings, paused, hidden } = this.session;
    if (settings.music && !paused && !hidden && !this.music.playing) this.music.play();
  }

  pauseMusic(): void {
    this.music.pause();
  }
  stopMusic(): void {
    this.music.stop();
  }
}
