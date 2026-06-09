.class public Lchat/ola/vn/b/r;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/r$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/message/f;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/view/LayoutInflater;

.field private b:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/r;->a:Landroid/view/LayoutInflater;

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/b/r;->b:Ljava/util/ArrayList;

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 7

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/r;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x6

    const/4 v2, 0x0

    if-ne v0, v1, :cond_1

    if-nez p2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/r;->a:Landroid/view/LayoutInflater;

    const v1, 0x7f0b007d

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/b/r;->a:Landroid/view/LayoutInflater;

    invoke-static {v0, p2}, Lchat/ola/vn/util/a;->a(Landroid/view/View;Landroid/view/LayoutInflater;)Lcom/google/android/gms/ads/AdView;

    move-object p2, p1

    check-cast p2, Lchat/ola/vn/message/a;

    const-wide/16 v1, 0x0

    iput-wide v1, p2, Lchat/ola/vn/message/a;->a:J
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p2, v0

    :cond_0
    :try_start_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    move-object v2, p1

    check-cast v2, Lchat/ola/vn/message/a;

    iget-wide v2, v2, Lchat/ola/vn/message/a;->a:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/32 v0, 0x2bf20

    cmp-long v2, v4, v0

    if-ltz v2, :cond_3

    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/ads/AdView;

    check-cast p1, Lchat/ola/vn/message/a;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, p1, Lchat/ola/vn/message/a;->a:J

    new-instance p1, Lcom/google/android/gms/ads/AdRequest$Builder;

    invoke-direct {p1}, Lcom/google/android/gms/ads/AdRequest$Builder;-><init>()V

    invoke-virtual {p1}, Lcom/google/android/gms/ads/AdRequest$Builder;->build()Lcom/google/android/gms/ads/AdRequest;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/ads/AdView;->loadAd(Lcom/google/android/gms/ads/AdRequest;)V

    goto :goto_1

    :cond_1
    if-nez p2, :cond_2

    iget-object v0, p0, Lchat/ola/vn/b/r;->a:Landroid/view/LayoutInflater;

    const v1, 0x7f0b0080

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :try_start_3
    new-instance p2, Lchat/ola/vn/b/r$a;

    invoke-direct {p2, p0, v0}, Lchat/ola/vn/b/r$a;-><init>(Lchat/ola/vn/b/r;Landroid/view/View;)V

    invoke-virtual {v0, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    :cond_2
    :try_start_4
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/b/r$a;
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    move-object v6, v0

    move-object v0, p2

    move-object p2, v6

    :goto_0
    const/4 v1, 0x0

    :try_start_5
    invoke-virtual {p2, p1, v1}, Lchat/ola/vn/b/r$a;->a(Lchat/ola/vn/message/f;Z)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_0

    :catch_0
    move-object p2, v0

    :catch_1
    :cond_3
    :goto_1
    if-nez p2, :cond_4

    return-object p3

    :cond_4
    return-object p2
.end method

.method public a(I)Lchat/ola/vn/message/f;
    .locals 1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->c(I)Lchat/ola/vn/message/f;

    move-result-object p1

    return-object p1
.end method

.method public getCount()I
    .locals 1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->j()I

    move-result v0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/r;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    return-object p1
.end method

.method public getItemViewType(I)I
    .locals 1

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/r;->a(I)Lchat/ola/vn/message/f;

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

.method public notifyDataSetChanged()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/b/j;->notifyDataSetChanged()V

    return-void
.end method
