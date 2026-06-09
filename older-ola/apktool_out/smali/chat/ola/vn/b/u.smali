.class public Lchat/ola/vn/b/u;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entry/b;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/view/LayoutInflater;

.field private b:Landroid/view/View$OnClickListener;

.field private c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/b;",
            ">;"
        }
    .end annotation
.end field

.field private d:Lchat/ola/vn/entry/b;

.field private g:Lchat/ola/vn/r/a/e;

.field private h:Landroid/view/View$OnLongClickListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/b/u;-><init>(Landroid/content/Context;Lchat/ola/vn/r/a/e;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lchat/ola/vn/r/a/e;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/u;->a:Landroid/view/LayoutInflater;

    iput-object p2, p0, Lchat/ola/vn/b/u;->g:Lchat/ola/vn/r/a/e;

    return-void
.end method

.method private a(Landroid/view/View;I)Landroid/view/View;
    .locals 3

    if-nez p1, :cond_0

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/b/u;->a:Landroid/view/LayoutInflater;

    const v0, 0x7f0b003a

    const/4 v1, 0x0

    invoke-virtual {p2, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    const p1, 0x7f09035a

    :try_start_1
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    const v0, 0x7f0f05d1

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    return-object p2

    :catch_0
    move-exception p1

    goto :goto_0

    :catch_1
    move-exception p2

    move-object v2, p2

    move-object p2, p1

    move-object p1, v2

    :goto_0
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    return-object p2

    :cond_0
    move-object p2, p1

    return-object p2
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 6

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/u;->getItemViewType(I)I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    invoke-direct {p0, p2, p1}, Lchat/ola/vn/b/u;->a(Landroid/view/View;I)Landroid/view/View;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 v1, 0x6

    if-ne v0, v1, :cond_3

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/u;->a(I)Lchat/ola/vn/entry/b;

    move-result-object p1

    if-nez p2, :cond_1

    iget-object v0, p0, Lchat/ola/vn/b/u;->a:Landroid/view/LayoutInflater;

    const v1, 0x7f0b00e9

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/b/u;->a:Landroid/view/LayoutInflater;

    invoke-static {v0, p2}, Lchat/ola/vn/util/a;->c(Landroid/view/View;Landroid/view/LayoutInflater;)Lcom/google/android/gms/ads/AdView;

    iget-object p2, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    const-wide/16 v1, 0x0

    invoke-virtual {p2, v1, v2}, Lchat/ola/vn/entity/g;->a(J)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p2, v0

    goto :goto_0

    :catch_0
    move-exception p1

    move-object p2, v0

    goto/16 :goto_4

    :cond_1
    :goto_0
    :try_start_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->d()J

    move-result-wide v2

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/32 v0, 0xea60

    cmp-long v2, v4, v0

    if-ltz v2, :cond_2

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/entity/g;->a(J)V

    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/google/android/gms/ads/AdView;

    new-instance v0, Lcom/google/android/gms/ads/AdRequest$Builder;

    invoke-direct {v0}, Lcom/google/android/gms/ads/AdRequest$Builder;-><init>()V

    invoke-virtual {v0}, Lcom/google/android/gms/ads/AdRequest$Builder;->build()Lcom/google/android/gms/ads/AdRequest;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/google/android/gms/ads/AdView;->loadAd(Lcom/google/android/gms/ads/AdRequest;)V

    :cond_2
    return-object p2

    :cond_3
    if-nez p2, :cond_4

    iget-object v1, p0, Lchat/ola/vn/b/u;->a:Landroid/view/LayoutInflater;

    invoke-static {v0, p2, v1}, Lchat/ola/vn/entry/b/i;->a(ILandroid/view/View;Landroid/view/LayoutInflater;)Lchat/ola/vn/entry/b/j;

    move-result-object v1

    :goto_1
    invoke-virtual {v1}, Lchat/ola/vn/entry/b/j;->c()Landroid/view/View;

    move-result-object v2
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_3

    move-object p2, v2

    goto :goto_2

    :cond_4
    :try_start_3
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entry/b/j;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_2

    :catch_1
    :try_start_4
    iget-object v1, p0, Lchat/ola/vn/b/u;->a:Landroid/view/LayoutInflater;

    invoke-static {v0, p2, v1}, Lchat/ola/vn/entry/b/i;->a(ILandroid/view/View;Landroid/view/LayoutInflater;)Lchat/ola/vn/entry/b/j;

    move-result-object v1

    goto :goto_1

    :goto_2
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/u;->a(I)Lchat/ola/vn/entry/b;

    move-result-object p1
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :try_start_5
    iget-object v2, p1, Lchat/ola/vn/entry/b;->e:[Ljava/lang/String;

    if-eqz v2, :cond_5

    iget-object v2, p1, Lchat/ola/vn/entry/b;->e:[Ljava/lang/String;

    array-length v2, v2

    if-lez v2, :cond_5

    move-object v2, v1

    check-cast v2, Lchat/ola/vn/entry/b/ab;

    iget-object v3, p1, Lchat/ola/vn/entry/b;->e:[Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "@"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, p1, Lchat/ola/vn/entry/b;->f:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, p2, v3, v4}, Lchat/ola/vn/entry/b/ab;->a(Landroid/view/View;[Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_3

    :cond_5
    move-object v2, v1

    check-cast v2, Lchat/ola/vn/entry/b/ab;

    invoke-virtual {v2}, Lchat/ola/vn/entry/b/ab;->e()V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    :catch_2
    :goto_3
    :try_start_6
    iget-object v2, p0, Lchat/ola/vn/b/u;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {v1, v2}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View$OnClickListener;)V

    iget-object v2, p0, Lchat/ola/vn/b/u;->h:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v1, v2}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View$OnLongClickListener;)V

    invoke-virtual {v1, p1}, Lchat/ola/vn/entry/b/j;->a(Lchat/ola/vn/entry/b;)V

    packed-switch v0, :pswitch_data_0

    :pswitch_0
    const/4 p1, 0x1

    invoke-virtual {v1, p1}, Lchat/ola/vn/entry/b/j;->a(Z)V

    invoke-virtual {v1}, Lchat/ola/vn/entry/b/j;->a()V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    goto :goto_5

    :catch_3
    move-exception p1

    :goto_4
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_5
    if-nez p2, :cond_6

    return-object p3

    :cond_6
    return-object p2

    :pswitch_data_0
    .packed-switch 0x4
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public a(I)Lchat/ola/vn/entry/b;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/u;->d:Lchat/ola/vn/entry/b;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/b/u;->d:Lchat/ola/vn/entry/b;

    return-object p1

    :cond_0
    const/4 v0, 0x0

    :cond_1
    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/b/u;->c:Ljava/util/List;

    sub-int/2addr p1, v0

    invoke-interface {v1, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/b;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/u;->b:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/u;->h:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public getCount()I
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/u;->d:Lchat/ola/vn/entry/b;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/b/u;->c:Ljava/util/List;

    if-nez v1, :cond_1

    return v0

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/b/u;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/2addr v1, v0

    return v1

    :catch_0
    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/u;->a(I)Lchat/ola/vn/entry/b;

    move-result-object p1

    return-object p1
.end method

.method public getItemId(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public getItemViewType(I)I
    .locals 0

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/u;->a(I)Lchat/ola/vn/entry/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entry/b;->d()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method

.method public getViewTypeCount()I
    .locals 1

    const/16 v0, 0xa

    return v0
.end method

.method public notifyDataSetChanged()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/u;->g:Lchat/ola/vn/r/a/e;

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    :cond_0
    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->f()Lchat/ola/vn/entry/b;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/b/u;->d:Lchat/ola/vn/entry/b;

    iget-object v1, p0, Lchat/ola/vn/b/u;->c:Ljava/util/List;

    if-nez v1, :cond_1

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lchat/ola/vn/b/u;->c:Ljava/util/List;

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/b/u;->c:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->i()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/b/u;->c:Ljava/util/List;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->i()Ljava/util/List;

    move-result-object v0

    invoke-interface {v1, v0}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_2
    invoke-super {p0}, Lchat/ola/vn/b/j;->notifyDataSetChanged()V

    return-void
.end method
