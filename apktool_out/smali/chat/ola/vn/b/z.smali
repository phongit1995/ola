.class public Lchat/ola/vn/b/z;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/message/f;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/view/LayoutInflater;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    return-void
.end method

.method private a()Landroid/view/LayoutInflater;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/z;->a:Landroid/view/LayoutInflater;

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    const-string v1, "layout_inflater"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/LayoutInflater;

    iput-object v0, p0, Lchat/ola/vn/b/z;->a:Landroid/view/LayoutInflater;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/z;->a:Landroid/view/LayoutInflater;

    return-object v0
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 8

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/z;->a(I)Lchat/ola/vn/message/f;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    const/4 v2, 0x6

    const/4 v3, 0x0

    if-ne v1, v2, :cond_1

    if-nez p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/z;->a:Landroid/view/LayoutInflater;

    const v1, 0x7f0b007d

    invoke-virtual {p1, v1, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_4

    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/b/z;->a:Landroid/view/LayoutInflater;

    invoke-static {p1, p2}, Lchat/ola/vn/util/a;->a(Landroid/view/View;Landroid/view/LayoutInflater;)Lcom/google/android/gms/ads/AdView;

    move-object p2, v0

    check-cast p2, Lchat/ola/vn/message/a;

    const-wide/16 v1, 0x0

    iput-wide v1, p2, Lchat/ola/vn/message/a;->a:J
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p2, p1

    goto :goto_0

    :catch_0
    move-exception p2

    move-object v7, p2

    move-object p2, p1

    move-object p1, v7

    goto/16 :goto_5

    :cond_0
    :goto_0
    :try_start_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    move-object p1, v0

    check-cast p1, Lchat/ola/vn/message/a;

    iget-wide v3, p1, Lchat/ola/vn/message/a;->a:J

    const/4 p1, 0x0

    sub-long v5, v1, v3

    const-wide/32 v1, 0x2bf20

    cmp-long p1, v5, v1

    if-ltz p1, :cond_6

    check-cast v0, Lchat/ola/vn/message/a;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/message/a;->a:J

    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/ads/AdView;

    new-instance v0, Lcom/google/android/gms/ads/AdRequest$Builder;

    invoke-direct {v0}, Lcom/google/android/gms/ads/AdRequest$Builder;-><init>()V

    invoke-virtual {v0}, Lcom/google/android/gms/ads/AdRequest$Builder;->build()Lcom/google/android/gms/ads/AdRequest;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/google/android/gms/ads/AdView;->loadAd(Lcom/google/android/gms/ads/AdRequest;)V

    goto/16 :goto_6

    :cond_1
    if-nez p2, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/b/z;->a()Landroid/view/LayoutInflater;

    move-result-object v1

    const v2, 0x7f0b0075

    invoke-virtual {v1, v2, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_4

    :try_start_3
    new-instance p2, Lchat/ola/vn/g/k;

    invoke-direct {p2, v0, v1}, Lchat/ola/vn/g/k;-><init>(Lchat/ola/vn/message/f;Landroid/view/View;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    move-object v7, v1

    move-object v1, p2

    move-object p2, v7

    goto :goto_1

    :catch_1
    move-exception p2

    move-object p1, p2

    move-object p2, v1

    goto :goto_5

    :cond_2
    :try_start_4
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    if-nez v1, :cond_3

    new-instance v1, Lchat/ola/vn/g/k;

    invoke-direct {v1, v0, p2}, Lchat/ola/vn/g/k;-><init>(Lchat/ola/vn/message/f;Landroid/view/View;)V

    goto :goto_1

    :cond_3
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/g/k;

    :goto_1
    invoke-virtual {v1, v0}, Lchat/ola/vn/g/k;->a(Lchat/ola/vn/message/f;)V

    const/4 v0, 0x1

    iput-boolean v0, v1, Lchat/ola/vn/g/k;->k:Z

    iput-boolean v0, v1, Lchat/ola/vn/g/k;->l:Z

    invoke-virtual {p2, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4

    add-int/lit8 v2, p1, -0x1

    :try_start_5
    invoke-virtual {p0, v2}, Lchat/ola/vn/b/z;->a(I)Lchat/ola/vn/message/f;

    move-result-object v2
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_2

    :catch_2
    move-object v2, v3

    :goto_2
    add-int/lit8 v4, p1, 0x1

    :try_start_6
    invoke-virtual {p0, v4}, Lchat/ola/vn/b/z;->a(I)Lchat/ola/vn/message/f;

    move-result-object v4
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    move-object v3, v4

    :catch_3
    const/4 v4, 0x0

    if-eqz v2, :cond_4

    :try_start_7
    invoke-virtual {v1, v4}, Lchat/ola/vn/g/k;->b(Z)V

    goto :goto_3

    :cond_4
    invoke-virtual {v1, v0}, Lchat/ola/vn/g/k;->b(Z)V

    :goto_3
    if-eqz v3, :cond_5

    invoke-virtual {v1, v4}, Lchat/ola/vn/g/k;->a(Z)V

    goto :goto_4

    :cond_5
    invoke-virtual {v1, v0}, Lchat/ola/vn/g/k;->a(Z)V

    :goto_4
    invoke-virtual {v1, p1}, Lchat/ola/vn/g/k;->a(I)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_4

    goto :goto_6

    :catch_4
    move-exception p1

    :goto_5
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_6
    :goto_6
    if-nez p2, :cond_7

    return-object p3

    :cond_7
    return-object p2
.end method

.method public a(I)Lchat/ola/vn/message/f;
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0, p1}, Lchat/ola/vn/r/a/f;->c(I)Lchat/ola/vn/message/f;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->g()I

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

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/z;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    return-object p1
.end method

.method public getItemViewType(I)I
    .locals 1

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/z;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x6

    if-ne p1, v0, :cond_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method public getViewTypeCount()I
    .locals 1

    const/4 v0, 0x2

    return v0
.end method
