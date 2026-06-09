package com.mg.ola.a.a.b;

/* JADX INFO: loaded from: classes2.dex */
public class d implements m<Number> {
    @Override // com.mg.ola.a.a.b.m
    public Float a(float f, Number number, Number number2) {
        float fFloatValue = number.floatValue();
        return Float.valueOf(fFloatValue + (f * (number2.floatValue() - fFloatValue)));
    }
}
