package com.facebook.places.model;

/* JADX INFO: loaded from: classes.dex */
public class CurrentPlaceFeedbackRequestParams {
    private final String placeId;
    private final String tracking;
    private final Boolean wasHere;

    public static class Builder {
        private String placeId;
        private String tracking;
        private Boolean wasHere;

        public CurrentPlaceFeedbackRequestParams build() {
            return new CurrentPlaceFeedbackRequestParams(this);
        }

        public Builder setPlaceId(String str) {
            this.placeId = str;
            return this;
        }

        public Builder setTracking(String str) {
            this.tracking = str;
            return this;
        }

        public Builder setWasHere(boolean z) {
            this.wasHere = Boolean.valueOf(z);
            return this;
        }
    }

    private CurrentPlaceFeedbackRequestParams(Builder builder) {
        this.tracking = builder.tracking;
        this.placeId = builder.placeId;
        this.wasHere = builder.wasHere;
    }

    public String getPlaceId() {
        return this.placeId;
    }

    public String getTracking() {
        return this.tracking;
    }

    public Boolean wasHere() {
        return this.wasHere;
    }
}
