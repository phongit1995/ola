package com.facebook.share.model;

import android.os.Parcel;
import android.support.annotation.Nullable;

/* JADX INFO: loaded from: classes.dex */
public abstract class ShareMessengerActionButton implements ShareModel {
    private final String title;

    public static abstract class Builder<M extends ShareMessengerActionButton, B extends Builder> implements ShareModelBuilder<M, B> {
        private String title;

        @Override // com.facebook.share.model.ShareModelBuilder
        public B readFrom(M m) {
            return m == null ? this : (B) setTitle(m.getTitle());
        }

        public B setTitle(@Nullable String str) {
            this.title = str;
            return this;
        }
    }

    ShareMessengerActionButton(Parcel parcel) {
        this.title = parcel.readString();
    }

    protected ShareMessengerActionButton(Builder builder) {
        this.title = builder.title;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public String getTitle() {
        return this.title;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeString(this.title);
    }
}
