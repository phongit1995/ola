.class public Lchat/ola/vn/b/ab;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entry/h;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/view/View$OnClickListener;

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/h;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/b/ab;-><init>(Landroid/content/Context;[Lchat/ola/vn/entry/h;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;[Lchat/ola/vn/entry/h;)V
    .locals 2

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    if-eqz p2, :cond_0

    array-length p1, p2

    if-lez p1, :cond_0

    new-instance p1, Ljava/util/ArrayList;

    array-length v0, p2

    invoke-direct {p1, v0}, Ljava/util/ArrayList;-><init>(I)V

    iput-object p1, p0, Lchat/ola/vn/b/ab;->b:Ljava/util/List;

    const/4 p1, 0x0

    :goto_0
    array-length v0, p2

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/ab;->b:Ljava/util/List;

    aget-object v1, p2, p1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    if-nez p2, :cond_0

    :try_start_0
    new-instance p3, Lchat/ola/vn/view/OlaSquareCachedImageView;

    invoke-virtual {p0}, Lchat/ola/vn/b/ab;->b()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p3, v0}, Lchat/ola/vn/view/OlaSquareCachedImageView;-><init>(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    move-object p2, p3

    check-cast p2, Landroid/widget/ImageView;

    const/4 v0, 0x1

    invoke-virtual {p2, v0}, Landroid/widget/ImageView;->setAdjustViewBounds(Z)V

    move-object p2, p3

    check-cast p2, Landroid/widget/ImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p2, v0}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object p2, p3

    goto :goto_0

    :catch_0
    move-object p2, p3

    return-object p2

    :cond_0
    :goto_0
    :try_start_2
    move-object p3, p2

    check-cast p3, Lchat/ola/vn/view/OlaSquareCachedImageView;

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ab;->a(I)Lchat/ola/vn/entry/h;

    move-result-object p1

    invoke-virtual {p3, p1}, Lchat/ola/vn/view/OlaSquareCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/b/ab;->a:Landroid/view/View$OnClickListener;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/b/ab;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {p3, v0}, Lchat/ola/vn/view/OlaSquareCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    iget p1, p1, Lchat/ola/vn/entry/h;->d:I

    invoke-virtual {p3, p1}, Lchat/ola/vn/view/OlaSquareCachedImageView;->setImageResource(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-object p2
.end method

.method public a(I)Lchat/ola/vn/entry/h;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/ab;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/h;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ab;->a:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/h;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/b/ab;->b:Ljava/util/List;

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/ab;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

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

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ab;->a(I)Lchat/ola/vn/entry/h;

    move-result-object p1

    return-object p1
.end method
