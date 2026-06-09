package com.facebook.accountkit;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.v7.widget.helper.ItemTouchHelper;
import com.facebook.accountkit.internal.InternalAccountKitError;

/* JADX INFO: loaded from: classes.dex */
public final class AccountKitError implements Parcelable {
    public static final Parcelable.Creator<AccountKitError> CREATOR = new Parcelable.Creator<AccountKitError>() { // from class: com.facebook.accountkit.AccountKitError.1
        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public AccountKitError createFromParcel(Parcel parcel) {
            return new AccountKitError(parcel);
        }

        /* JADX WARN: Can't rename method to resolve collision */
        @Override // android.os.Parcelable.Creator
        public AccountKitError[] newArray(int i) {
            return new AccountKitError[i];
        }
    };
    private final Type errorType;
    private final InternalAccountKitError internalError;

    public enum Type {
        NETWORK_CONNECTION_ERROR(100, "A request failed due to a network error"),
        SERVER_ERROR(ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION, "Server generated an error"),
        LOGIN_INVALIDATED(300, "The request timed out"),
        INTERNAL_ERROR(400, "An internal consistency error has occurred"),
        INITIALIZATION_ERROR(500, "Initialization error"),
        ARGUMENT_ERROR(600, "Invalid argument provided"),
        UPDATE_INVALIDATED(700, "The update request timed out");

        private final int code;
        private final String message;

        Type(int i, String str) {
            this.code = i;
            this.message = str;
        }

        public int getCode() {
            return this.code;
        }

        public String getMessage() {
            return this.message;
        }

        @Override // java.lang.Enum
        public String toString() {
            return this.code + ": " + this.message;
        }
    }

    private AccountKitError(Parcel parcel) {
        this.errorType = Type.values()[parcel.readInt()];
        this.internalError = (InternalAccountKitError) parcel.readParcelable(InternalAccountKitError.class.getClassLoader());
    }

    public AccountKitError(Type type) {
        this(type, (InternalAccountKitError) null);
    }

    public AccountKitError(Type type, InternalAccountKitError internalAccountKitError) {
        this.errorType = type;
        this.internalError = internalAccountKitError;
    }

    @Override // android.os.Parcelable
    public int describeContents() {
        return 0;
    }

    public int getDetailErrorCode() {
        if (this.internalError == null) {
            return -1;
        }
        return this.internalError.getCode();
    }

    public Type getErrorType() {
        return this.errorType;
    }

    public String getUserFacingMessage() {
        if (this.internalError == null) {
            return null;
        }
        return this.internalError.getUserFacingMessage();
    }

    public String toString() {
        return this.errorType + ": " + this.internalError;
    }

    @Override // android.os.Parcelable
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeInt(this.errorType.ordinal());
        parcel.writeParcelable(this.internalError, i);
    }
}
