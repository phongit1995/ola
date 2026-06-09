.class final Lchat/ola/vn/util/a$3;
.super Lcom/google/android/gms/ads/AdListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/a;->c(Landroid/view/View;Landroid/view/LayoutInflater;)Lcom/google/android/gms/ads/AdView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/google/android/gms/ads/AdListener;-><init>()V

    return-void
.end method


# virtual methods
.method public onAdClosed()V
    .locals 0

    invoke-super {p0}, Lcom/google/android/gms/ads/AdListener;->onAdClosed()V

    return-void
.end method

.method public onAdFailedToLoad(I)V
    .locals 0

    invoke-super {p0, p1}, Lcom/google/android/gms/ads/AdListener;->onAdFailedToLoad(I)V

    return-void
.end method

.method public onAdLeftApplication()V
    .locals 0

    invoke-super {p0}, Lcom/google/android/gms/ads/AdListener;->onAdLeftApplication()V

    return-void
.end method

.method public onAdLoaded()V
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/ads/AdListener;->onAdLoaded()V

    const/4 v0, 0x1

    sput-boolean v0, Lchat/ola/vn/util/a;->c:Z

    return-void
.end method

.method public onAdOpened()V
    .locals 1

    invoke-super {p0}, Lcom/google/android/gms/ads/AdListener;->onAdOpened()V

    const/4 v0, 0x1

    sput-boolean v0, Lchat/ola/vn/util/a;->c:Z

    return-void
.end method
