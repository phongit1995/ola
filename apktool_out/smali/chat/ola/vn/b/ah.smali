.class public Lchat/ola/vn/b/ah;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/c;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation
.end field

.field private c:Landroid/view/LayoutInflater;

.field private d:Landroid/view/View$OnClickListener;

.field private g:Landroid/view/View$OnLongClickListener;

.field private h:F

.field private i:Lchat/ola/vn/entity/t;

.field private j:I

.field private k:I

.field private l:Landroid/view/View;

.field private m:J


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/b/ah;->l:Landroid/view/View;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/b/ah;->m:J

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/b/ah;->c:Landroid/view/LayoutInflater;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f070141

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/b/ah;->j:I

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f070125

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/b/ah;->k:I

    return-void
.end method

.method private a(ILandroid/view/View;Landroid/view/ViewGroup;I)Landroid/view/View;
    .locals 6

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ah;->getItem(I)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/entry/c;

    const/4 v0, 0x5

    if-nez p2, :cond_1

    if-ne p4, v0, :cond_0

    iget-object v1, p3, Lchat/ola/vn/entry/c;->a:Lchat/ola/vn/entity/k;

    if-nez v1, :cond_0

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lchat/ola/vn/b/ah;->m:J

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/b/ah;->b()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/b/ah;->c:Landroid/view/LayoutInflater;

    invoke-static {v1, v2, p3, p4}, Lchat/ola/vn/entry/b/l;->a(Landroid/content/Context;Landroid/view/LayoutInflater;Lchat/ola/vn/entry/c;I)Landroid/view/View;

    move-result-object v1

    move-object p2, v1

    :cond_1
    if-ne p4, v0, :cond_2

    iget-object p4, p3, Lchat/ola/vn/entry/c;->a:Lchat/ola/vn/entity/k;

    if-nez p4, :cond_2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/b/ah;->m:J

    const/4 p4, 0x0

    sub-long v4, v0, v2

    const-wide/32 v0, 0xea60

    cmp-long p4, v4, v0

    if-ltz p4, :cond_2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/b/ah;->m:J

    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Lcom/google/android/gms/ads/AdView;

    new-instance v0, Lcom/google/android/gms/ads/AdRequest$Builder;

    invoke-direct {v0}, Lcom/google/android/gms/ads/AdRequest$Builder;-><init>()V

    invoke-virtual {v0}, Lcom/google/android/gms/ads/AdRequest$Builder;->build()Lcom/google/android/gms/ads/AdRequest;

    move-result-object v0

    invoke-virtual {p4, v0}, Lcom/google/android/gms/ads/AdView;->loadAd(Lcom/google/android/gms/ads/AdRequest;)V

    :cond_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Lchat/ola/vn/entry/b/l;

    if-eqz p4, :cond_3

    iget-object v0, p0, Lchat/ola/vn/b/ah;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p4, v0}, Lchat/ola/vn/entry/b/l;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/b/ah;->g:Landroid/view/View$OnLongClickListener;

    invoke-virtual {p4, v0}, Lchat/ola/vn/entry/b/l;->a(Landroid/view/View$OnLongClickListener;)V

    iget v0, p0, Lchat/ola/vn/b/ah;->h:F

    invoke-virtual {p4, v0}, Lchat/ola/vn/entry/b/l;->a(F)V

    invoke-virtual {p4, p3, p1}, Lchat/ola/vn/entry/b/l;->a(Lchat/ola/vn/entry/c;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-object p2
.end method

.method private a(Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 2

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    :cond_0
    return-void
.end method

.method private c()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/ah;->a:Ljava/util/List;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/ah;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method


# virtual methods
.method public a()I
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/ah;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    :goto_0
    iget-object v1, p0, Lchat/ola/vn/b/ah;->i:Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-eqz v5, :cond_0

    add-int/lit8 v0, v0, 0x1

    :cond_0
    return v0
.end method

.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 5

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ah;->getItemViewType(I)I

    move-result v0

    const/4 v1, 0x7

    if-ge v0, v1, :cond_0

    invoke-direct {p0, p1, p2, p3, v0}, Lchat/ola/vn/b/ah;->a(ILandroid/view/View;Landroid/view/ViewGroup;I)Landroid/view/View;

    move-result-object p2

    return-object p2

    :cond_0
    const/16 v2, 0x10

    const/4 v3, 0x0

    if-ne v0, v2, :cond_4

    if-nez p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/b/ah;->c:Landroid/view/LayoutInflater;

    const p2, 0x7f0b01a2

    invoke-virtual {p1, p2, p3, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/ah;->l:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/b/ah;->l:Landroid/view/View;

    const p2, 0x7f0902a6

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-direct {p0, p1}, Lchat/ola/vn/b/ah;->a(Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object p1, p0, Lchat/ola/vn/b/ah;->d:Landroid/view/View$OnClickListener;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/b/ah;->l:Landroid/view/View;

    const p2, 0x7f090588

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/b/ah;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, p2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/b/ah;->l:Landroid/view/View;

    return-object p1

    :cond_2
    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/b/ah;->l:Landroid/view/View;

    const p3, 0x7f0902fe

    invoke-virtual {p1, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/b/ah;->a()I

    move-result p3

    const/4 v0, 0x1

    if-ne p3, v0, :cond_3

    const p3, 0x7f0800cf

    invoke-virtual {p1, p3}, Landroid/view/View;->setBackgroundResource(I)V

    goto :goto_0

    :cond_3
    const p3, 0x7f0800ac

    invoke-virtual {p1, p3}, Landroid/view/View;->setBackgroundResource(I)V

    :goto_0
    iget p3, p0, Lchat/ola/vn/b/ah;->k:I

    iget v0, p0, Lchat/ola/vn/b/ah;->k:I

    iget v1, p0, Lchat/ola/vn/b/ah;->k:I

    iget v2, p0, Lchat/ola/vn/b/ah;->k:I

    invoke-virtual {p1, p3, v0, v1, v2}, Landroid/view/View;->setPadding(IIII)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    return-object p2

    :cond_4
    sub-int/2addr v0, v1

    if-nez p2, :cond_5

    :catch_0
    iget-object p3, p0, Lchat/ola/vn/b/ah;->c:Landroid/view/LayoutInflater;

    invoke-static {v0, p2, p3}, Lchat/ola/vn/entry/b/i;->a(ILandroid/view/View;Landroid/view/LayoutInflater;)Lchat/ola/vn/entry/b/j;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/entry/b/j;->c()Landroid/view/View;

    move-result-object p3

    goto :goto_1

    :cond_5
    :try_start_1
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/entry/b/j;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v4, p3

    move-object p3, p2

    move-object p2, v4

    :goto_1
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ah;->getItem(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/b/ah;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p2, v1}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/b/ah;->g:Landroid/view/View$OnLongClickListener;

    invoke-virtual {p2, v1}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View$OnLongClickListener;)V

    invoke-virtual {p2, v0}, Lchat/ola/vn/entry/b/j;->a(Lchat/ola/vn/entry/b;)V

    invoke-virtual {p2}, Lchat/ola/vn/entry/b/j;->b()V

    invoke-virtual {p2}, Lchat/ola/vn/entry/b/j;->a()V

    invoke-virtual {p2, v3}, Lchat/ola/vn/entry/b/j;->a(Z)V

    invoke-virtual {p0, p1, p2, v0}, Lchat/ola/vn/b/ah;->a(ILchat/ola/vn/entry/b/j;Lchat/ola/vn/entry/b;)V

    move-object p2, p3

    :catch_1
    return-object p2
.end method

.method public a(F)V
    .locals 1

    iget v0, p0, Lchat/ola/vn/b/ah;->h:F

    cmpl-float v0, v0, p1

    if-eqz v0, :cond_0

    iput p1, p0, Lchat/ola/vn/b/ah;->h:F

    invoke-virtual {p0}, Lchat/ola/vn/b/ah;->notifyDataSetChanged()V

    :cond_0
    return-void
.end method

.method protected a(ILchat/ola/vn/entry/b/j;Lchat/ola/vn/entry/b;)V
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/b/ah;->getCount()I

    move-result p3

    const/4 v0, 0x1

    sub-int/2addr p3, v0

    if-ne p1, p3, :cond_0

    const p1, 0x7f0800a9

    :goto_0
    invoke-virtual {p2, p1}, Lchat/ola/vn/entry/b/j;->a(I)V

    goto :goto_1

    :cond_0
    const p1, 0x7f0800a8

    goto :goto_0

    :goto_1
    iget p1, p0, Lchat/ola/vn/b/ah;->j:I

    iget p3, p0, Lchat/ola/vn/b/ah;->j:I

    const/4 v1, 0x0

    invoke-virtual {p2, p1, v0, p3, v1}, Lchat/ola/vn/entry/b/j;->a(IIII)V

    return-void
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ah;->d:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ah;->g:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public a(Lchat/ola/vn/entity/t;)V
    .locals 1

    if-nez p1, :cond_0

    const/4 v0, 0x0

    :try_start_0
    iput-object v0, p0, Lchat/ola/vn/b/ah;->a:Ljava/util/List;

    iput-object v0, p0, Lchat/ola/vn/b/ah;->b:Ljava/util/List;

    return-void

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->e()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/b/ah;->a:Ljava/util/List;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->d()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/b/ah;->b:Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iput-object p1, p0, Lchat/ola/vn/b/ah;->i:Lchat/ola/vn/entity/t;

    return-void
.end method

.method public getCount()I
    .locals 2

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/b/ah;->c()I

    move-result v0

    invoke-virtual {p0}, Lchat/ola/vn/b/ah;->a()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/2addr v0, v1

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 6

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/b/ah;->c()I

    move-result v0

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/ah;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    :cond_0
    const-wide/16 v1, 0x0

    if-ne p1, v0, :cond_1

    iget-object v3, p0, Lchat/ola/vn/b/ah;->i:Lchat/ola/vn/entity/t;

    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v3

    cmp-long v5, v3, v1

    if-eqz v5, :cond_1

    new-instance p1, Ljava/lang/Object;

    invoke-direct {p1}, Ljava/lang/Object;-><init>()V

    return-object p1

    :cond_1
    iget-object v3, p0, Lchat/ola/vn/b/ah;->i:Lchat/ola/vn/entity/t;

    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v3

    cmp-long v5, v3, v1

    if-eqz v5, :cond_2

    iget-object v1, p0, Lchat/ola/vn/b/ah;->b:Ljava/util/List;

    add-int/lit8 p1, p1, -0x1

    sub-int/2addr p1, v0

    invoke-interface {v1, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/b/ah;->b:Ljava/util/List;

    sub-int/2addr p1, v0

    invoke-interface {v1, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public getItemViewType(I)I
    .locals 6

    invoke-direct {p0}, Lchat/ola/vn/b/ah;->c()I

    move-result v0

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/ah;->a:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/c;

    invoke-virtual {p1}, Lchat/ola/vn/entry/c;->c()S

    move-result p1

    return p1

    :cond_0
    const-wide/16 v1, 0x0

    if-ne p1, v0, :cond_1

    iget-object v3, p0, Lchat/ola/vn/b/ah;->i:Lchat/ola/vn/entity/t;

    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v3

    cmp-long v5, v3, v1

    if-eqz v5, :cond_1

    const/16 p1, 0x10

    return p1

    :cond_1
    iget-object v3, p0, Lchat/ola/vn/b/ah;->i:Lchat/ola/vn/entity/t;

    invoke-virtual {v3}, Lchat/ola/vn/entity/t;->r()J

    move-result-wide v3

    cmp-long v5, v3, v1

    if-eqz v5, :cond_2

    iget-object v1, p0, Lchat/ola/vn/b/ah;->b:Ljava/util/List;

    add-int/lit8 p1, p1, -0x1

    sub-int/2addr p1, v0

    invoke-interface {v1, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b;->d()I

    move-result p1

    add-int/lit8 p1, p1, 0x7

    return p1

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/b/ah;->b:Ljava/util/List;

    sub-int/2addr p1, v0

    invoke-interface {v1, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b;->d()I

    move-result p1

    add-int/lit8 p1, p1, 0x7

    return p1
.end method

.method public getViewTypeCount()I
    .locals 1

    const/16 v0, 0x11

    return v0
.end method

.method public notifyDataSetChanged()V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/ah;->i:Lchat/ola/vn/entity/t;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/ah;->i:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->e()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/b/ah;->a:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/b/ah;->i:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->d()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/b/ah;->b:Ljava/util/List;

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/b/j;->notifyDataSetChanged()V

    return-void
.end method
