package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class ch {
    private static ch b;
    bb[] a = new bb[256];

    private ch() {
        this.a[0] = new ab();
        this.a[1] = new da();
        this.a[2] = new dv();
        this.a[5] = new az();
        this.a[8] = new ae();
        this.a[9] = new af();
        this.a[10] = new bc();
        this.a[12] = new y();
        this.a[14] = new Cdo();
        this.a[15] = new c();
        this.a[16] = new cs();
        this.a[17] = new d();
        this.a[18] = new ct();
        this.a[19] = new bj();
        this.a[20] = new cu();
        this.a[21] = new m();
        this.a[22] = new bh();
        this.a[23] = new am();
        this.a[25] = new l();
        this.a[39] = new dl();
        this.a[42] = new cm();
        this.a[44] = new ds();
        this.a[50] = new ai();
        this.a[53] = new z();
        this.a[54] = new i();
        this.a[55] = new g();
        this.a[57] = new e();
        this.a[61] = new dt();
        this.a[62] = new aa();
        this.a[65] = new q();
        this.a[66] = new p();
        this.a[67] = new ad();
        this.a[68] = new ak();
        this.a[69] = new du();
        this.a[70] = new aj();
        this.a[72] = new bm();
        this.a[73] = new bn();
        this.a[74] = new bo();
        this.a[75] = new w();
        this.a[76] = new dc();
        this.a[77] = new ax();
        this.a[79] = new bl();
        this.a[80] = new dj();
        this.a[81] = new at();
        this.a[82] = new ar();
        this.a[84] = new ea();
        this.a[85] = new bf();
        this.a[86] = new cr();
        this.a[87] = new dn();
        this.a[91] = new bg();
        this.a[92] = new ed();
        this.a[95] = new cx();
        this.a[96] = new cz();
        this.a[97] = new ba();
        this.a[103] = new ee();
        this.a[104] = new cw();
        this.a[106] = new co();
        this.a[107] = new r();
        this.a[109] = new cl();
        this.a[110] = new ck();
        this.a[111] = new u();
        this.a[116] = new cj();
        this.a[117] = new au();
        this.a[122] = new dw();
        this.a[123] = new dx();
        this.a[124] = new db();
        this.a[125] = new h();
        this.a[128] = new dd();
        this.a[138] = new aw();
        this.a[139] = new o();
        this.a[140] = new av();
        this.a[142] = new cy();
        this.a[143] = new a();
        this.a[146] = new x();
        this.a[147] = new ay();
        this.a[148] = new dp();
        this.a[149] = new n();
        this.a[150] = new b();
        this.a[158] = new be();
        this.a[159] = new bd();
        this.a[160] = new dg();
        this.a[161] = new cq();
        this.a[162] = new dm();
        this.a[163] = new dk();
        this.a[164] = new ag();
        this.a[165] = new ah();
        this.a[166] = new de();
        this.a[167] = new di();
        this.a[168] = new aq();
        this.a[169] = new ap();
        this.a[170] = new v();
        this.a[172] = new cp();
        this.a[176] = new an();
        this.a[177] = new ao();
        this.a[178] = new cv();
        this.a[188] = new cn();
        this.a[189] = new ec();
        this.a[190] = new t();
        this.a[193] = new ac();
        this.a[194] = new as();
        this.a[195] = new df();
        this.a[196] = new dy();
        this.a[197] = new dz();
        this.a[198] = new eb();
        this.a[200] = new j();
        this.a[201] = new k();
        this.a[202] = new al();
        this.a[203] = new bi();
        this.a[204] = new bp();
        this.a[206] = new f();
        this.a[207] = new dh();
        this.a[209] = new cc();
        this.a[210] = new br();
    }

    public static ch a() {
        if (b == null) {
            b = new ch();
        }
        return b;
    }

    public bb a(short s) {
        if (s < 0 || s >= this.a.length) {
            return null;
        }
        return this.a[s];
    }
}
