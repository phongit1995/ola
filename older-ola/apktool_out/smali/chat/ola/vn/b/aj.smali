.class public Lchat/ola/vn/b/aj;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/aj$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entity/t;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/view/LayoutInflater;

.field private b:Lchat/ola/vn/entity/t;

.field private c:J


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/b/aj;->c:J

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/aj;->a:Landroid/view/LayoutInflater;

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 7

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/aj;->a(I)Lchat/ola/vn/entity/t;

    move-result-object v6

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/aj;->getItemViewType(I)I

    move-result v4

    const/4 v0, 0x3

    if-ne v4, v0, :cond_4

    if-nez p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/b/aj;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->m()S

    move-result p1

    const/4 p2, 0x0

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/b/aj;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->m()S

    move-result p1

    const/4 p3, 0x1

    if-ne p1, p3, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/b/aj;->a:Landroid/view/LayoutInflater;

    const p3, 0x7f0b019d

    invoke-virtual {p1, p3, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/b/aj;->a:Landroid/view/LayoutInflater;

    invoke-static {p1, p2}, Lchat/ola/vn/util/a;->b(Landroid/view/View;Landroid/view/LayoutInflater;)Lcom/google/android/gms/ads/AdView;

    goto :goto_1

    :cond_1
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/b/aj;->a:Landroid/view/LayoutInflater;

    const p3, 0x7f0b019e

    invoke-virtual {p1, p3, p2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/b/aj;->a:Landroid/view/LayoutInflater;

    invoke-static {p1, p2}, Lchat/ola/vn/util/a;->a(Landroid/view/View;Landroid/view/LayoutInflater;)Lcom/google/android/gms/ads/AdView;

    :goto_1
    move-object p2, p1

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/b/aj;->c:J

    :cond_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/b/aj;->c:J

    sub-long v4, v0, v2

    const-wide/32 v0, 0xea60

    cmp-long p1, v4, v0

    if-ltz p1, :cond_3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/b/aj;->c:J

    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/ads/AdView;

    new-instance p3, Lcom/google/android/gms/ads/AdRequest$Builder;

    invoke-direct {p3}, Lcom/google/android/gms/ads/AdRequest$Builder;-><init>()V

    invoke-virtual {p3}, Lcom/google/android/gms/ads/AdRequest$Builder;->build()Lcom/google/android/gms/ads/AdRequest;

    move-result-object p3

    invoke-virtual {p1, p3}, Lcom/google/android/gms/ads/AdView;->loadAd(Lcom/google/android/gms/ads/AdRequest;)V

    :cond_3
    return-object p2

    :cond_4
    if-nez p2, :cond_5

    iget-object v0, p0, Lchat/ola/vn/b/aj;->a:Landroid/view/LayoutInflater;

    iget-object p2, p0, Lchat/ola/vn/b/aj;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p2}, Lchat/ola/vn/entity/t;->m()S

    move-result v5

    move-object v1, p3

    move-object v2, v6

    move v3, p1

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/b/aj$a;->a(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Lchat/ola/vn/entity/t;IIS)Landroid/view/View;

    move-result-object p2

    :cond_5
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/b/aj$a;

    invoke-virtual {p3, v6, p1}, Lchat/ola/vn/b/aj$a;->a(Lchat/ola/vn/entity/t;I)V

    return-object p2
.end method

.method public a(I)Lchat/ola/vn/entity/t;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/aj;->b:Lchat/ola/vn/entity/t;

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/aj;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0, p1}, Lchat/ola/vn/entity/t;->a(I)Lchat/ola/vn/entity/t;

    move-result-object p1

    return-object p1
.end method

.method public a(Lchat/ola/vn/entity/t;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/aj;->b:Lchat/ola/vn/entity/t;

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/aj;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->i()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/aj;->a(I)Lchat/ola/vn/entity/t;

    move-result-object p1

    return-object p1
.end method

.method public getItemViewType(I)I
    .locals 3

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/aj;->a(I)Lchat/ola/vn/entity/t;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->h()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->p()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->n()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x3

    return p1

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->h()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->p()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v2, 0x1

    if-nez v0, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->n()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    return v2

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->h()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/entity/i;->b(Ljava/lang/String;)[I

    move-result-object p1

    :try_start_0
    aget v0, p1, v1

    int-to-float v0, v0

    aget p1, p1, v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    int-to-float p1, p1

    div-float/2addr v0, p1

    const p1, 0x3fe38e39

    cmpl-float p1, v0, p1

    if-ltz p1, :cond_3

    const/4 p1, 0x2

    return p1

    :cond_2
    return v2

    :catch_0
    :cond_3
    return v1
.end method

.method public getViewTypeCount()I
    .locals 1

    const/4 v0, 0x4

    return v0
.end method
