package com.google.android.gms.internal.ads;

import java.security.GeneralSecurityException;
import java.security.KeyPair;
import java.security.interfaces.ECPrivateKey;
import java.security.interfaces.ECPublicKey;
import java.security.spec.ECParameterSpec;
import java.security.spec.ECPoint;
import java.security.spec.EllipticCurve;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/* JADX INFO: loaded from: classes.dex */
public final class zzayr {
    private ECPublicKey zzdnj;

    public zzayr(ECPublicKey eCPublicKey) {
        this.zzdnj = eCPublicKey;
    }

    public final zzays zza(String str, byte[] bArr, byte[] bArr2, int i, zzayw zzaywVar) throws GeneralSecurityException {
        byte[] bArr3;
        KeyPair keyPairZza = zzayt.zza(this.zzdnj.getParams());
        ECPublicKey eCPublicKey = (ECPublicKey) keyPairZza.getPublic();
        ECPrivateKey eCPrivateKey = (ECPrivateKey) keyPairZza.getPrivate();
        ECPublicKey eCPublicKey2 = this.zzdnj;
        ECParameterSpec params = eCPublicKey2.getParams();
        ECParameterSpec params2 = eCPrivateKey.getParams();
        if (!params.getCurve().equals(params2.getCurve()) || !params.getGenerator().equals(params2.getGenerator()) || !params.getOrder().equals(params2.getOrder()) || params.getCofactor() != params2.getCofactor()) {
            throw new GeneralSecurityException("invalid public key spec");
        }
        byte[] bArrZza = zzayt.zza(eCPrivateKey, eCPublicKey2.getW());
        EllipticCurve curve = eCPublicKey.getParams().getCurve();
        ECPoint w = eCPublicKey.getW();
        zzayt.zza(w, curve);
        int iZzb = zzayt.zzb(curve);
        int i2 = 1;
        switch (zzaywVar) {
            case UNCOMPRESSED:
                int i3 = (iZzb * 2) + 1;
                byte[] bArr4 = new byte[i3];
                byte[] byteArray = w.getAffineX().toByteArray();
                byte[] byteArray2 = w.getAffineY().toByteArray();
                System.arraycopy(byteArray2, 0, bArr4, i3 - byteArray2.length, byteArray2.length);
                System.arraycopy(byteArray, 0, bArr4, (iZzb + 1) - byteArray.length, byteArray.length);
                bArr4[0] = 4;
                bArr3 = bArr4;
                break;
            case COMPRESSED:
                int i4 = iZzb + 1;
                bArr3 = new byte[i4];
                byte[] byteArray3 = w.getAffineX().toByteArray();
                System.arraycopy(byteArray3, 0, bArr3, i4 - byteArray3.length, byteArray3.length);
                bArr3[0] = (byte) (w.getAffineY().testBit(0) ? 3 : 2);
                break;
            default:
                String strValueOf = String.valueOf(zzaywVar);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 15);
                sb.append("invalid format:");
                sb.append(strValueOf);
                throw new GeneralSecurityException(sb.toString());
        }
        byte[] bArrZza2 = zzayk.zza(bArr3, bArrZza);
        Mac macZzek = zzayy.zzdoa.zzek(str);
        if (i > macZzek.getMacLength() * 255) {
            throw new GeneralSecurityException("size too large");
        }
        if (bArr == null || bArr.length == 0) {
            macZzek.init(new SecretKeySpec(new byte[macZzek.getMacLength()], str));
        } else {
            macZzek.init(new SecretKeySpec(bArr, str));
        }
        byte[] bArrDoFinal = macZzek.doFinal(bArrZza2);
        byte[] bArr5 = new byte[i];
        macZzek.init(new SecretKeySpec(bArrDoFinal, str));
        byte[] bArrDoFinal2 = new byte[0];
        int length = 0;
        while (true) {
            macZzek.update(bArrDoFinal2);
            macZzek.update(bArr2);
            macZzek.update((byte) i2);
            bArrDoFinal2 = macZzek.doFinal();
            if (bArrDoFinal2.length + length >= i) {
                System.arraycopy(bArrDoFinal2, 0, bArr5, length, i - length);
                return new zzays(bArr3, bArr5);
            }
            System.arraycopy(bArrDoFinal2, 0, bArr5, length, bArrDoFinal2.length);
            length += bArrDoFinal2.length;
            i2++;
        }
    }
}
