.class public Lchat/ola/vn/b/s$a;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/s;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation


# instance fields
.field a:Lchat/ola/vn/view/OlaCachedImageView;

.field b:Landroid/view/View;

.field c:Landroid/view/View;

.field d:Landroid/view/View;

.field final synthetic e:Lchat/ola/vn/b/s;

.field private f:Lchat/ola/vn/entity/ab;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/s;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/s$a;->e:Lchat/ola/vn/b/s;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f0903ce

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0905e4

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/s$a;->c:Landroid/view/View;

    const p1, 0x7f0901df

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/s$a;->b:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->b:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903d0

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/s$a;->d:Landroid/view/View;

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/ab;)V
    .locals 8

    iput-object p1, p0, Lchat/ola/vn/b/s$a;->f:Lchat/ola/vn/entity/ab;

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->e:Lchat/ola/vn/b/s;

    invoke-static {p1}, Lchat/ola/vn/b/s;->a(Lchat/ola/vn/b/s;)Z

    move-result p1

    const/4 v0, 0x0

    const/16 v1, 0x8

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->b:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->b:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/b/s$a;->f:Lchat/ola/vn/entity/ab;

    invoke-virtual {p1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/b/s$a;->b:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/b/s$a;->f:Lchat/ola/vn/entity/ab;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->f:Lchat/ola/vn/entity/ab;

    iget-short p1, p1, Lchat/ola/vn/entity/ab;->a:S

    const/4 v2, 0x1

    if-ne p1, v2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->f:Lchat/ola/vn/entity/ab;

    iget-byte p1, p1, Lchat/ola/vn/entity/ab;->b:B

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->c:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/b/s$a;->f:Lchat/ola/vn/entity/ab;

    iget-object v0, v0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/b/s$a;->d:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v3}, Lchat/ola/vn/view/OlaCachedImageView;->getWidth()I

    move-result v3

    invoke-virtual {p1, v0, v1, v2, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/b/s$a;->c:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->f:Lchat/ola/vn/entity/ab;

    iget-object v3, p1, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v5, p0, Lchat/ola/vn/b/s$a;->d:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaCachedImageView;->getWidth()I

    move-result v6

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaCachedImageView;->getHeight()I

    move-result v7

    invoke-virtual/range {v2 .. v7}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;II)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/b/s$a;->f:Lchat/ola/vn/entity/ab;

    iget-short p1, p1, Lchat/ola/vn/entity/ab;->a:S

    const/4 v2, 0x2

    if-ne p1, v2, :cond_4

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->f:Lchat/ola/vn/entity/ab;

    iget-byte p1, p1, Lchat/ola/vn/entity/ab;->b:B

    const v2, 0x7f08071a

    if-nez p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->c:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->d:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/b/s$a;->c:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->d:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/b/s$a;->f:Lchat/ola/vn/entity/ab;

    iget-object v0, v0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v0, v1, v2}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    :cond_4
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 7

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0901df

    if-eq v0, v1, :cond_4

    const v1, 0x7f0903ce

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/ab;

    iget-object v0, p0, Lchat/ola/vn/b/s$a;->e:Lchat/ola/vn/b/s;

    invoke-static {v0}, Lchat/ola/vn/b/s;->b(Lchat/ola/vn/b/s;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [Lchat/ola/vn/mediastore/OlaMediaEntity;

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    array-length v3, v0

    if-ge v1, v3, :cond_3

    iget-object v3, p0, Lchat/ola/vn/b/s$a;->e:Lchat/ola/vn/b/s;

    invoke-static {v3}, Lchat/ola/vn/b/s;->b(Lchat/ola/vn/b/s;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/ab;

    invoke-virtual {v3, p1}, Lchat/ola/vn/entity/ab;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    move v2, v1

    :cond_1
    iget-byte v4, v3, Lchat/ola/vn/entity/ab;->b:B

    const/4 v5, 0x1

    if-nez v4, :cond_2

    new-instance v4, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object v3, v3, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-direct {v4, v3, v5, v5}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    aput-object v4, v0, v1

    goto :goto_1

    :cond_2
    new-instance v4, Lchat/ola/vn/mediastore/OlaMediaEntity;

    iget-object v3, v3, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    const/4 v6, 0x2

    invoke-direct {v4, v3, v6, v5}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    aput-object v4, v0, v1

    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_3
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/b/s$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v3, 0x0

    invoke-static {p1, v1, v3, v2, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;I[Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    return-void

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/b/s$a;->e:Lchat/ola/vn/b/s;

    invoke-static {v0}, Lchat/ola/vn/b/s;->a(Lchat/ola/vn/b/s;)Z

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/ab;

    iget-object v0, p0, Lchat/ola/vn/b/s$a;->e:Lchat/ola/vn/b/s;

    invoke-static {v0}, Lchat/ola/vn/b/s;->b(Lchat/ola/vn/b/s;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    iget-object p1, p0, Lchat/ola/vn/b/s$a;->e:Lchat/ola/vn/b/s;

    invoke-virtual {p1}, Lchat/ola/vn/b/s;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_5
    return-void
.end method
