.class public interface abstract Lcom/google/android/gms/internal/maps/zzz;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/IInterface;


# virtual methods
.method public abstract getColor()I
.end method

.method public abstract getEndCap()Lcom/google/android/gms/maps/model/Cap;
.end method

.method public abstract getId()Ljava/lang/String;
.end method

.method public abstract getJointType()I
.end method

.method public abstract getPattern()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/google/android/gms/maps/model/PatternItem;",
            ">;"
        }
    .end annotation
.end method

.method public abstract getPoints()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/google/android/gms/maps/model/LatLng;",
            ">;"
        }
    .end annotation
.end method

.method public abstract getStartCap()Lcom/google/android/gms/maps/model/Cap;
.end method

.method public abstract getWidth()F
.end method

.method public abstract getZIndex()F
.end method

.method public abstract isClickable()Z
.end method

.method public abstract isGeodesic()Z
.end method

.method public abstract isVisible()Z
.end method

.method public abstract remove()V
.end method

.method public abstract setClickable(Z)V
.end method

.method public abstract setColor(I)V
.end method

.method public abstract setEndCap(Lcom/google/android/gms/maps/model/Cap;)V
.end method

.method public abstract setGeodesic(Z)V
.end method

.method public abstract setJointType(I)V
.end method

.method public abstract setPattern(Ljava/util/List;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/google/android/gms/maps/model/PatternItem;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract setPoints(Ljava/util/List;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/google/android/gms/maps/model/LatLng;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract setStartCap(Lcom/google/android/gms/maps/model/Cap;)V
.end method

.method public abstract setVisible(Z)V
.end method

.method public abstract setWidth(F)V
.end method

.method public abstract setZIndex(F)V
.end method

.method public abstract zzb(Lcom/google/android/gms/internal/maps/zzz;)Z
.end method

.method public abstract zze(Lcom/google/android/gms/dynamic/IObjectWrapper;)V
.end method

.method public abstract zzi()I
.end method

.method public abstract zzj()Lcom/google/android/gms/dynamic/IObjectWrapper;
.end method
