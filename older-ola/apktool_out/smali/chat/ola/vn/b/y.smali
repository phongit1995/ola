.class public Lchat/ola/vn/b/y;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/y$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entity/s;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/view/LayoutInflater;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    const-string v0, "layout_inflater"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/LayoutInflater;

    iput-object p1, p0, Lchat/ola/vn/b/y;->a:Landroid/view/LayoutInflater;

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 11

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/y;->a(I)Lchat/ola/vn/entity/s;

    move-result-object v0

    const/4 v1, 0x2

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-nez p2, :cond_3

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/y;->getItemViewType(I)I

    move-result v4

    if-ne v4, v2, :cond_0

    iget-object v4, p0, Lchat/ola/vn/b/y;->a:Landroid/view/LayoutInflater;

    const v5, 0x7f0b00cf

    invoke-virtual {v4, v5, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    :goto_0
    move-object p2, v4

    goto :goto_1

    :cond_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/y;->getItemViewType(I)I

    move-result v4

    if-ne v4, v1, :cond_1

    iget-object v4, p0, Lchat/ola/vn/b/y;->a:Landroid/view/LayoutInflater;

    const v5, 0x7f0b007d

    invoke-virtual {v4, v5, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_4

    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/b/y;->a:Landroid/view/LayoutInflater;

    invoke-static {v4, p2}, Lchat/ola/vn/util/a;->a(Landroid/view/View;Landroid/view/LayoutInflater;)Lcom/google/android/gms/ads/AdView;

    const-wide/16 v5, 0x0

    iput-wide v5, v0, Lchat/ola/vn/entity/s;->b:J
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-object p2, v4

    goto/16 :goto_5

    :cond_1
    :try_start_2
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/y;->getItemViewType(I)I

    move-result v4

    const/4 v5, 0x3

    if-ne v4, v5, :cond_2

    iget-object v4, p0, Lchat/ola/vn/b/y;->a:Landroid/view/LayoutInflater;

    const v5, 0x7f0b019b

    invoke-virtual {v4, v5, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    goto :goto_0

    :cond_2
    iget-object v4, p0, Lchat/ola/vn/b/y;->a:Landroid/view/LayoutInflater;

    const v5, 0x7f0b019a

    invoke-virtual {v4, v5, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v4

    goto :goto_0

    :goto_1
    new-instance v4, Lchat/ola/vn/b/y$a;

    invoke-direct {v4, p0, p2}, Lchat/ola/vn/b/y$a;-><init>(Lchat/ola/vn/b/y;Landroid/view/View;)V

    goto :goto_2

    :cond_3
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v4

    if-nez v4, :cond_4

    new-instance v4, Lchat/ola/vn/b/y$a;

    invoke-direct {v4, p0, p2}, Lchat/ola/vn/b/y$a;-><init>(Lchat/ola/vn/b/y;Landroid/view/View;)V

    goto :goto_2

    :cond_4
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/b/y$a;

    :goto_2
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/y;->getItemViewType(I)I

    move-result v5

    if-ne v5, v1, :cond_5

    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    if-eqz v1, :cond_5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    iget-wide v7, v0, Lchat/ola/vn/entity/s;->b:J
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_4

    const/4 v1, 0x0

    sub-long v9, v5, v7

    const-wide/32 v5, 0x2bf20

    cmp-long v1, v9, v5

    if-ltz v1, :cond_5

    :try_start_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    iput-wide v5, v0, Lchat/ola/vn/entity/s;->b:J

    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/google/android/gms/ads/AdView;

    new-instance v5, Lcom/google/android/gms/ads/AdRequest$Builder;

    invoke-direct {v5}, Lcom/google/android/gms/ads/AdRequest$Builder;-><init>()V

    invoke-virtual {v5}, Lcom/google/android/gms/ads/AdRequest$Builder;->build()Lcom/google/android/gms/ads/AdRequest;

    move-result-object v5

    invoke-virtual {v1, v5}, Lcom/google/android/gms/ads/AdView;->loadAd(Lcom/google/android/gms/ads/AdRequest;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :cond_5
    :try_start_4
    invoke-virtual {p2, v4}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_4

    add-int/lit8 v1, p1, -0x1

    :try_start_5
    invoke-virtual {p0, v1}, Lchat/ola/vn/b/y;->a(I)Lchat/ola/vn/entity/s;

    move-result-object v1
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    goto :goto_3

    :catch_2
    move-object v1, v3

    :goto_3
    add-int/2addr p1, v2

    :try_start_6
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/y;->a(I)Lchat/ola/vn/entity/s;

    move-result-object p1
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    goto :goto_4

    :catch_3
    move-object p1, v3

    :goto_4
    :try_start_7
    invoke-virtual {v4, v0, v1, p1}, Lchat/ola/vn/b/y$a;->a(Lchat/ola/vn/entity/s;Lchat/ola/vn/entity/s;Lchat/ola/vn/entity/s;)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_4

    :catch_4
    :goto_5
    if-nez p2, :cond_6

    return-object p3

    :cond_6
    return-object p2
.end method

.method public a(I)Lchat/ola/vn/entity/s;
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0, p1}, Lchat/ola/vn/r/a/f;->b(I)Lchat/ola/vn/entity/s;

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

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->f()I

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

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/y;->a(I)Lchat/ola/vn/entity/s;

    move-result-object p1

    return-object p1
.end method

.method public getItemViewType(I)I
    .locals 3

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/y;->a(I)Lchat/ola/vn/entity/s;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->h()B

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->h()B

    move-result v0

    const/4 v2, 0x4

    if-ne v0, v2, :cond_1

    return v1

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->h()B

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x6

    if-ne p1, v0, :cond_2

    const/4 p1, 0x3

    return p1

    :catch_0
    :cond_2
    const/4 p1, 0x0

    return p1
.end method

.method public getViewTypeCount()I
    .locals 1

    const/4 v0, 0x4

    return v0
.end method
