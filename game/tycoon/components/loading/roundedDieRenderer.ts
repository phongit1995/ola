import { loadingFrame, type LoadingFrame } from './loadingMotion';

export function createRoundedDieRenderer(
  canvas: HTMLCanvasElement,
  onFallback: () => void,
  onFrame: (frame: LoadingFrame) => void,
): { dispose(): void } | null {
  const gl = canvas.getContext('webgl', {
    alpha: true, antialias: true, premultipliedAlpha: true, preserveDrawingBuffer: true,
  });
  if (!gl) { onFallback(); return null; }

  const vertex=`
    attribute vec3 aPosition;
    attribute vec3 aNormal;
    attribute vec2 aUV;
    attribute float aValue;
    uniform mat3 uRotation;
    uniform float uOutline;
    uniform float uScale;
    varying vec3 vNormal;
    varying vec2 vUV;
    varying float vValue;
    void main(){
      vec3 p=uRotation*(aPosition+aNormal*uOutline);
      vNormal=uRotation*aNormal;
      vUV=aUV;vValue=aValue;
      gl_Position=vec4(p.xy*uScale,-p.z*.4,1.);
    }`;
  const fragment=`
    precision highp float;
    uniform int uPass;
    varying vec3 vNormal;
    varying vec2 vUV;
    varying float vValue;
    float pip(vec2 p){
      float diagonal=min(distance(p,vec2(.27,.73)),distance(p,vec2(.73,.27)));
      float corners=min(diagonal,min(distance(p,vec2(.27,.27)),distance(p,vec2(.73,.73))));
      if(vValue<1.5)return distance(p,vec2(.5));
      if(vValue<2.5)return diagonal;
      if(vValue<3.5)return min(diagonal,distance(p,vec2(.5)));
      if(vValue<4.5)return corners;
      if(vValue<5.5)return min(corners,distance(p,vec2(.5)));
      return min(corners,min(distance(p,vec2(.27,.5)),distance(p,vec2(.73,.5))));
    }
    void main(){
      vec3 ink=vec3(.016,.04,.24);
      if(uPass==1){gl_FragColor=vec4(ink,1.);return;}
      vec3 n=normalize(vNormal);
      float light=dot(n,normalize(vec3(-.45,.65,1.)));
      float shade=1.-smoothstep(-.1,.6,light);
      vec3 paper=mix(vec3(.995,.995,1.),vec3(.76,.77,.87),shade);
      float radius=vValue>5.5?.101:.128;
      float spot=1.-smoothstep(radius-.006,radius+.006,pip(vUV));
      gl_FragColor=vec4(mix(paper,ink,spot),1.);
    }`;

  const shadersToDelete: WebGLShader[] = [];
  let program: WebGLProgram | null = null;
  let buffer: WebGLBuffer | null = null;
  const releaseResources = () => {
    if (buffer) gl.deleteBuffer(buffer);
    if (program) gl.deleteProgram(program);
    shadersToDelete.forEach(shader => gl.deleteShader(shader));
  };
  const compile = (type: number, text: string) => {
    const shader = gl.createShader(type);
    if (!shader) throw new Error('Cannot allocate die shader');
    shadersToDelete.push(shader);
    gl.shaderSource(shader, text);
    gl.compileShader(shader);
    if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) throw new Error('Cannot compile die shader');
    return shader;
  };
  try {
    program = gl.createProgram();
    if (!program) throw new Error('Cannot allocate die program');
    gl.attachShader(program, compile(gl.VERTEX_SHADER, vertex));
    gl.attachShader(program, compile(gl.FRAGMENT_SHADER, fragment));
    gl.linkProgram(program);
    if (!gl.getProgramParameter(program, gl.LINK_STATUS)) throw new Error('Cannot link die program');
    buffer = gl.createBuffer();
    if (!buffer) throw new Error('Cannot allocate die buffer');
  } catch {
    releaseResources();
    onFallback();
    return null;
  }
  gl.useProgram(program);
  const faces=[
    {value:2,n:[0,0,1],u:[1,0,0],v:[0,1,0]},
    {value:5,n:[0,0,-1],u:[-1,0,0],v:[0,1,0]},
    {value:1,n:[1,0,0],u:[0,0,-1],v:[0,1,0]},
    {value:6,n:[-1,0,0],u:[0,0,1],v:[0,1,0]},
    {value:3,n:[0,1,0],u:[1,0,0],v:[0,0,-1]},
    {value:4,n:[0,-1,0],u:[1,0,0],v:[0,0,1]},
  ];
  const vertices: number[] = [];
  const radius=.13,core=.5-radius,segments=24;
  const point=(face: (typeof faces)[number], i: number, j: number)=>{
    const u=i/segments-.5,v=j/segments-.5;
    const p=face.n.map((n,k)=>n*.5+face.u[k]*u+face.v[k]*v);
    const q=p.map(x=>Math.max(-core,Math.min(core,x)));
    let normal=p.map((x,k)=>x-q[k]);const len=Math.hypot(...normal);normal=normal.map(x=>x/len);
    const position=q.map((x,k)=>x+radius*normal[k]);
    vertices.push(...position,...normal,u+.5,v+.5,face.value);
  };
  for(const face of faces)for(let i=0;i<segments;i++)for(let j=0;j<segments;j++){
    point(face,i,j);point(face,i+1,j);point(face,i+1,j+1);
    point(face,i,j);point(face,i+1,j+1);point(face,i,j+1);
  }

  gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);
  const attributes: [string, number, number][] = [
    ['aPosition', 3, 0], ['aNormal', 3, 3], ['aUV', 2, 6], ['aValue', 1, 8],
  ];
  for (const [name, size, offset] of attributes) {
    const at = gl.getAttribLocation(program, name);
    gl.enableVertexAttribArray(at);
    gl.vertexAttribPointer(at, size, gl.FLOAT, false, 36, offset * 4);
  }
  const uniforms = {
    rotation: gl.getUniformLocation(program, 'uRotation'),
    outline: gl.getUniformLocation(program, 'uOutline'),
    scale: gl.getUniformLocation(program, 'uScale'),
    pass: gl.getUniformLocation(program, 'uPass'),
  };
  const scale = 1.12, outline = .052;
  gl.uniform1f(uniforms.scale, scale);
  gl.enable(gl.DEPTH_TEST);
  gl.enable(gl.CULL_FACE);
  gl.frontFace(gl.CCW);
  gl.clearColor(0, 0, 0, 0);
  const mul=(a: number[], b: number[])=>{const r=Array(9).fill(0);for(let c=0;c<3;c++)for(let row=0;row<3;row++)for(let k=0;k<3;k++)r[c*3+row]+=a[k*3+row]*b[c*3+k];return r;};
  const rotation=(x: number, y: number)=>{x*=Math.PI/180;y*=Math.PI/180;return mul([1,0,0,0,Math.cos(x),Math.sin(x),0,-Math.sin(x),Math.cos(x)],[Math.cos(y),0,-Math.sin(y),0,1,0,Math.sin(y),0,Math.cos(y)]);};
  let current = 0, last = performance.now(), request = 0;
  let disposed = false;
  const preference = matchMedia('(prefers-reduced-motion: reduce)');
  const stopped = () => disposed || preference.matches || document.hidden;
  const render = (time: number) => {
    if (disposed) return;
    const frame = loadingFrame(preference.matches ? 0 : time);
    onFrame(frame);
    const [x, y] = frame.dieAngles;
    const matrix = rotation(x, y);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
    gl.uniformMatrix3fv(uniforms.rotation, false, new Float32Array(matrix));
    gl.cullFace(gl.FRONT);
    gl.uniform1i(uniforms.pass, 1);
    gl.uniform1f(uniforms.outline, outline);
    gl.drawArrays(gl.TRIANGLES, 0, vertices.length / 9);
    gl.cullFace(gl.BACK);
    gl.uniform1i(uniforms.pass, 0);
    gl.uniform1f(uniforms.outline, 0);
    gl.drawArrays(gl.TRIANGLES, 0, vertices.length / 9);
  };
  const resize = () => {
    if (disposed) return;
    const bounds = canvas.getBoundingClientRect();
    const dpr = Math.min(devicePixelRatio || 1, 3);
    const width = Math.max(1, Math.round(bounds.width * dpr));
    if (canvas.width !== width || canvas.height !== width) {
      canvas.width = width;
      canvas.height = width;
      gl.viewport(0, 0, width, width);
    }
    render(current);
  };
  const tick = (now: number) => {
    request = 0;
    if (stopped()) {
      if (!disposed && preference.matches) render(0);
      return;
    }
    current += Math.min(100, Math.max(0, now - last));
    last = now;
    render(current);
    request = requestAnimationFrame(tick);
  };
  const sync = () => {
    if (request) cancelAnimationFrame(request);
    request = 0;
    if (disposed) return;
    last = performance.now();
    render(current);
    if (!stopped()) request = requestAnimationFrame(tick);
  };
  const observer = new ResizeObserver(resize);
  const dispose = () => {
    if (disposed) return;
    disposed = true;
    if (request) cancelAnimationFrame(request);
    request = 0;
    observer.disconnect();
    preference.removeEventListener('change', sync);
    document.removeEventListener('visibilitychange', sync);
    canvas.removeEventListener('webglcontextlost', contextLost);
    releaseResources();
  };
  const contextLost = (event: Event) => {
    event.preventDefault();
    dispose();
    onFallback();
  };
  observer.observe(canvas);
  preference.addEventListener('change', sync);
  document.addEventListener('visibilitychange', sync);
  canvas.addEventListener('webglcontextlost', contextLost);
  resize();
  sync();

  return { dispose };
}
