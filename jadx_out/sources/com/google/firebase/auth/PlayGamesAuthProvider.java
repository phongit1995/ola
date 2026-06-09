package com.google.firebase.auth;

import android.support.annotation.NonNull;

/* JADX INFO: loaded from: classes2.dex */
public class PlayGamesAuthProvider {
    public static final String PLAY_GAMES_SIGN_IN_METHOD = "playgames.google.com";
    public static final String PROVIDER_ID = "playgames.google.com";

    private PlayGamesAuthProvider() {
    }

    public static AuthCredential getCredential(@NonNull String str) {
        return new PlayGamesAuthCredential(str);
    }
}
