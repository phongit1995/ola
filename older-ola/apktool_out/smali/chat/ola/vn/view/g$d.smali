.class Lchat/ola/vn/view/g$d;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "d"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/g;

.field private b:Landroid/view/View;

.field private c:Landroid/view/View;

.field private d:Landroid/view/View;

.field private e:Lchat/ola/vn/view/OlaCachedImageView;

.field private f:Landroid/view/View;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Lchat/ola/vn/view/g;Landroid/view/View;Ljava/lang/String;)V
    .locals 2

    iput-object p1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const v0, 0x7f0903cf

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/view/g$d;->b:Landroid/view/View;

    const v0, 0x7f090461

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/view/g$d;->c:Landroid/view/View;

    const v0, 0x7f0905e3

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/view/g$d;->d:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->b:Landroid/view/View;

    invoke-virtual {v0, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f0903ce

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/view/g$d;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-static {p1}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;)I

    move-result v0

    if-lez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    invoke-static {p1}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;)I

    move-result v1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-static {p1}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;)I

    move-result v1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    iget-object v1, p0, Lchat/ola/vn/view/g$d;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->c:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    invoke-static {p1}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;)I

    move-result v1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-static {p1}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;)I

    move-result v1

    iput v1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    iget-object v1, p0, Lchat/ola/vn/view/g$d;->c:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->d:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    invoke-static {p1}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;)I

    move-result p1

    iput p1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->d:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    :cond_0
    const p1, 0x7f0905e9

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/g$d;->f:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->f:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090465

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/view/g$d;->g:Landroid/widget/TextView;

    const p1, 0x7f0905e2

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/view/g$d;->h:Landroid/widget/TextView;

    invoke-static {p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->g:Landroid/widget/TextView;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/view/g$d;->g:Landroid/widget/TextView;

    const p2, 0x7f0f0612

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/view/g$d;->g:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private c()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->c:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->c(Lchat/ola/vn/view/g;)Landroid/view/animation/Animation;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/animation/Animation;->cancel()V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->c:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {v1}, Lchat/ola/vn/view/g;->c(Lchat/ola/vn/view/g;)Landroid/view/animation/Animation;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->c:Landroid/view/View;

    const/16 v1, 0x8

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->e(Lchat/ola/vn/view/g;)Landroid/view/animation/Animation;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/animation/Animation;->cancel()V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->c:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {v1}, Lchat/ola/vn/view/g;->e(Lchat/ola/vn/view/g;)Landroid/view/animation/Animation;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->c:Landroid/view/View;

    const/4 v1, 0x0

    goto :goto_0

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/g$d;->c:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/i;)V
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->f:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->g:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f08071a

    const/4 v2, 0x2

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/16 v6, 0x8

    if-eqz v0, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v7

    if-ne v7, v3, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->d:Landroid/view/View;

    invoke-virtual {p1, v6}, Landroid/view/View;->setVisibility(I)V

    const/16 p1, 0x140

    iget-object v1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {v1}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;)I

    move-result v1

    if-lez v1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {p1}, Lchat/ola/vn/view/g;->b(Lchat/ola/vn/view/g;)I

    move-result p1

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/view/g$d;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0, v2, p1}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    return-void

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result p1

    if-ne p1, v2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->d:Landroid/view/View;

    invoke-virtual {p1, v4}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->e:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->h:Landroid/widget/TextView;

    invoke-virtual {p1, v6}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/view/g$d;->d:Landroid/view/View;

    invoke-virtual {p1, v6}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v5, v5}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    return-void

    :cond_3
    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v0

    if-ne v0, v3, :cond_4

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->d:Landroid/view/View;

    invoke-virtual {v0, v6}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->h()Ljava/lang/String;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/g$d;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1, v1}, Lchat/ola/vn/c/t;->e(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void

    :cond_4
    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v0

    if-ne v0, v2, :cond_2

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->h:Landroid/widget/TextView;

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->h:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->l()J

    move-result-wide v2

    const-wide/16 v5, 0x3e8

    div-long/2addr v2, v5

    const-string v5, ":"

    const-string v6, ":"

    invoke-static {v2, v3, v5, v6}, Lcom/mg/ola/common/d/i;->a(JLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->d:Landroid/view/View;

    invoke-virtual {v0, v4}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->h()Ljava/lang/String;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/view/g$d;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1, v2, v1}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    return-void
.end method

.method public b()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {v0}, Lchat/ola/vn/view/g;->c(Lchat/ola/vn/view/g;)Landroid/view/animation/Animation;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/animation/Animation;->cancel()V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->c:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {v1}, Lchat/ola/vn/view/g;->c(Lchat/ola/vn/view/g;)Landroid/view/animation/Animation;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->c:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 6

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f0903cf

    if-eq v0, v1, :cond_8

    const v1, 0x7f090465

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x1

    if-eq v0, v1, :cond_4

    const v1, 0x7f0905e9

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/i;

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    iget-object v0, v0, Lchat/ola/vn/view/g;->a:Lchat/ola/vn/view/g$e;

    if-eqz v0, :cond_a

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v5

    if-ne v5, v4, :cond_1

    new-array p1, v4, [Lchat/ola/vn/mediastore/OlaMediaEntity;

    new-instance v3, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-static {v0}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result v5

    invoke-direct {v3, v0, v4, v5}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    aput-object v3, p1, v1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/view/g$d;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-static {v0, v3, v2, v1, p1}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;I[Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    return-void

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v0

    if-ne v0, v3, :cond_a

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lchat/ola/vn/util/b;->h(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_2
    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v0

    if-ne v0, v4, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->h()Ljava/lang/String;

    move-result-object p1

    new-array v0, v4, [Lchat/ola/vn/mediastore/OlaMediaEntity;

    new-instance v5, Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-direct {v5, p1, v3, v4}, Lchat/ola/vn/mediastore/OlaMediaEntity;-><init>(Ljava/lang/String;IS)V

    aput-object v5, v0, v1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    iget-object v3, p0, Lchat/ola/vn/view/g$d;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-static {p1, v3, v2, v1, v0}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Landroid/content/Context;Landroid/view/View;Landroid/graphics/Bitmap;I[Lchat/ola/vn/mediastore/OlaMediaEntity;)V

    return-void

    :cond_3
    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v0

    if-ne v0, v3, :cond_a

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->h()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1, v1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;I)V

    return-void

    :cond_4
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/i;

    invoke-virtual {p0}, Lchat/ola/vn/view/g$d;->b()V

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {v0, v2}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;Lchat/ola/vn/view/g$d;)Lchat/ola/vn/view/g$d;

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    iget-object v0, v0, Lchat/ola/vn/view/g;->a:Lchat/ola/vn/view/g$e;

    if-eqz v0, :cond_a

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_6

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v1

    if-ne v1, v4, :cond_5

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    iget-object p1, p1, Lchat/ola/vn/view/g;->a:Lchat/ola/vn/view/g$e;

    invoke-interface {p1, v0}, Lchat/ola/vn/view/g$e;->j(Ljava/lang/String;)V

    return-void

    :cond_5
    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result p1

    if-ne p1, v3, :cond_a

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    iget-object p1, p1, Lchat/ola/vn/view/g;->a:Lchat/ola/vn/view/g$e;

    invoke-interface {p1, v0}, Lchat/ola/vn/view/g$e;->k(Ljava/lang/String;)V

    return-void

    :cond_6
    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v0

    if-ne v0, v4, :cond_7

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->h()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    iget-object v0, v0, Lchat/ola/vn/view/g;->a:Lchat/ola/vn/view/g$e;

    invoke-interface {v0, p1}, Lchat/ola/vn/view/g$e;->h(Ljava/lang/String;)V

    return-void

    :cond_7
    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->f()S

    move-result v0

    if-ne v0, v3, :cond_a

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->h()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    iget-object v0, v0, Lchat/ola/vn/view/g;->a:Lchat/ola/vn/view/g$e;

    invoke-interface {v0, p1}, Lchat/ola/vn/view/g$e;->i(Ljava/lang/String;)V

    return-void

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {p1}, Lchat/ola/vn/view/g;->d(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$d;

    move-result-object p1

    if-eqz p1, :cond_9

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {p1}, Lchat/ola/vn/view/g;->d(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$d;

    move-result-object p1

    if-eq p1, p0, :cond_9

    iget-object p1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {p1}, Lchat/ola/vn/view/g;->d(Lchat/ola/vn/view/g;)Lchat/ola/vn/view/g$d;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/view/g$d;->b()V

    :cond_9
    iget-object p1, p0, Lchat/ola/vn/view/g$d;->a:Lchat/ola/vn/view/g;

    invoke-static {p1, p0}, Lchat/ola/vn/view/g;->a(Lchat/ola/vn/view/g;Lchat/ola/vn/view/g$d;)Lchat/ola/vn/view/g$d;

    invoke-direct {p0}, Lchat/ola/vn/view/g$d;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_a
    return-void
.end method
