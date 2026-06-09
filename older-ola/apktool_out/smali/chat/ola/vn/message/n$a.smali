.class public Lchat/ola/vn/message/n$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/message/n;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4
    name = "a"
.end annotation


# instance fields
.field protected a:Lchat/ola/vn/view/OlaCachedImageView;

.field protected b:Lchat/ola/vn/view/OlaCachedImageView;

.field protected c:Landroid/widget/TextView;

.field protected d:Landroid/widget/TextView;

.field protected e:Landroid/widget/TextView;

.field protected f:Landroid/widget/TextView;

.field protected g:Lchat/ola/vn/message/f;

.field protected h:Landroid/view/View;

.field protected i:Landroid/view/View;

.field final synthetic j:Lchat/ola/vn/message/n;


# direct methods
.method public constructor <init>(Lchat/ola/vn/message/n;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/n$a;->j:Lchat/ola/vn/message/n;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f090281

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/message/n$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f090358

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/message/n$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f09052a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    const p1, 0x7f0904ca

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    const p1, 0x7f090529

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    const p1, 0x7f09059f

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    const p1, 0x7f090096

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/message/n$a;->i:Landroid/view/View;

    iput-object p2, p0, Lchat/ola/vn/message/n$a;->h:Landroid/view/View;

    return-void
.end method

.method private a()V
    .locals 11

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->z()I

    move-result v0

    const/4 v1, 0x0

    if-lez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v2

    const/4 v3, 0x1

    invoke-static {v2, v3}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v2

    invoke-static {v2, v3}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->y:I

    :goto_0
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v2

    invoke-static {v2, v1}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v2

    invoke-static {v2, v1}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->z:I

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->a()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    const/16 v6, 0x8

    if-lez v0, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    sub-long v9, v7, v2

    cmp-long v0, v9, v4

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/b;->c()[Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/b;->b()[Ljava/lang/String;

    move-result-object v3

    invoke-static {v9, v10, v1, v2, v3}, Lcom/mg/ola/common/d/i;->a(J[Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_2
    invoke-direct {p0}, Lchat/ola/vn/message/n$a;->c()V

    invoke-direct {p0}, Lchat/ola/vn/message/n$a;->d()V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->z()I

    move-result v0

    invoke-direct {p0, v0}, Lchat/ola/vn/message/n$a;->a(I)V

    invoke-direct {p0}, Lchat/ola/vn/message/n$a;->e()V

    return-void
.end method

.method private a(I)V
    .locals 2

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->clearAnimation()V

    iget-object p1, p0, Lchat/ola/vn/message/n$a;->h:Landroid/view/View;

    sget v0, Lchat/ola/vn/f;->d:I

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setBackgroundColor(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, ""

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/message/n$a;->h:Landroid/view/View;

    sget v0, Lchat/ola/vn/f;->I:I

    goto :goto_0

    return-void
.end method

.method private a(Lchat/ola/vn/message/o;)V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    const/16 v2, 0x8

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f08079a

    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    invoke-virtual {p1}, Lchat/ola/vn/message/o;->z()I

    move-result p1

    if-lez p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v3, p1

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p1, 0x7f0f067a

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    invoke-virtual {p1, v1, v1, v1, v1}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    iget-object p1, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    const v0, 0x7f0f0594

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->clearAnimation()V

    iget-object p1, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->getAnimation()Landroid/view/animation/Animation;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->getAnimation()Landroid/view/animation/Animation;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/animation/Animation;->cancel()V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_1
    return-void
.end method

.method private b()V
    .locals 12

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    check-cast v0, Lchat/ola/vn/message/u;

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->d:Landroid/widget/TextView;

    const/16 v3, 0x8

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->f:Landroid/widget/TextView;

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    iget-object v3, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    invoke-virtual {v3}, Landroid/widget/TextView;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v3

    const/4 v4, 0x1

    invoke-static {v3, v4}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;I)Landroid/graphics/Typeface;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->c:Landroid/widget/TextView;

    invoke-virtual {v0}, Lchat/ola/vn/message/u;->Y()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    invoke-virtual {v0}, Lchat/ola/vn/message/u;->Z()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    invoke-virtual {v1, v2, v2, v2, v2}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->h:Landroid/view/View;

    sget v2, Lchat/ola/vn/f;->I:I

    invoke-virtual {v1, v2}, Landroid/view/View;->setBackgroundColor(I)V

    invoke-virtual {v0}, Lchat/ola/vn/message/u;->aa()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    const v2, 0x7f08078d

    if-nez v1, :cond_1

    invoke-virtual {v0}, Lchat/ola/vn/message/u;->aa()Ljava/lang/String;

    move-result-object v1

    sget-object v3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    const-string v3, "http"

    invoke-virtual {v1, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/message/u;->aa()Ljava/lang/String;

    move-result-object v3

    iget-object v5, p0, Lchat/ola/vn/message/n$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v3, v5, v2, v4}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;IZ)V

    goto :goto_1

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v6

    invoke-virtual {v0}, Lchat/ola/vn/message/u;->aa()Ljava/lang/String;

    move-result-object v7

    iget-object v8, p0, Lchat/ola/vn/message/n$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v9, 0x7f08078d

    const/16 v10, 0x60

    const/4 v11, 0x1

    invoke-virtual/range {v6 .. v11}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;IIZ)V

    goto :goto_1

    :cond_1
    invoke-virtual {v0}, Lchat/ola/vn/message/u;->ac()I

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/message/u;->ac()I

    move-result v2

    :goto_0
    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    goto :goto_1

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/message/n$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    goto :goto_0

    :goto_1
    invoke-virtual {v0}, Lchat/ola/vn/message/u;->ab()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/message/n$a;->a(Ljava/lang/String;)V

    return-void
.end method

.method private c()V
    .locals 13

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->w()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    invoke-virtual {v2, v3, v3, v3, v3}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    iget-wide v4, v2, Lchat/ola/vn/message/f;->s:J

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->a()J

    move-result-wide v6

    cmp-long v2, v4, v6

    const/4 v4, 0x4

    const/4 v5, 0x1

    const/4 v6, 0x2

    if-lez v2, :cond_2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    iget-wide v9, v2, Lchat/ola/vn/message/f;->s:J

    const/4 v2, 0x0

    sub-long v11, v7, v9

    const-wide/16 v7, 0xbb8

    cmp-long v2, v11, v7

    if-gez v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    if-ne v2, v6, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    const v1, 0x7f0f01d0

    new-array v2, v5, [Ljava/lang/Object;

    iget-object v4, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    iget-object v4, v4, Lchat/ola/vn/message/f;->n:Ljava/lang/String;

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Lchat/ola/vn/OlaApplication;->a(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->k()S

    move-result v2

    if-ne v2, v4, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    const v1, 0x7f0f01d1

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    :goto_0
    const-string v2, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    if-eqz v0, :cond_5

    :try_start_1
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->k()Ljava/lang/String;

    move-result-object v7
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :try_start_2
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->d()B

    move-result v1

    if-ne v1, v6, :cond_3

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const v4, 0x7f0f06c3

    invoke-static {v4}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ": "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    move-object v2, v1

    goto :goto_2

    :cond_3
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->d()B

    move-result v1

    if-ne v1, v5, :cond_6

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    if-eq v1, v6, :cond_4

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    if-ne v1, v4, :cond_6

    :cond_4
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ": "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    :catch_0
    :cond_5
    move-object v7, v1

    :catch_1
    :cond_6
    :goto_2
    if-eqz v0, :cond_e

    :try_start_3
    iget-object v1, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    const-string v4, ""

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->x()Z

    move-result v1

    if-eqz v1, :cond_7

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    const v1, 0x7f080742

    invoke-virtual {v0, v1, v3, v3, v3}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    return-void

    :cond_7
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->e()B

    move-result v1

    const/4 v4, 0x3

    if-ne v1, v4, :cond_8

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    const v1, 0x7f080747

    invoke-virtual {v0, v1, v3, v3, v3}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    return-void

    :cond_8
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->e()B

    move-result v1

    const/4 v4, 0x6

    if-eq v1, v4, :cond_d

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->e()B

    move-result v1

    const/4 v4, 0x7

    if-ne v1, v4, :cond_9

    goto :goto_4

    :cond_9
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->e()B

    move-result v1

    const/16 v4, 0xe

    if-ne v1, v4, :cond_a

    const v0, 0x7f0f0636

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v7

    goto :goto_5

    :cond_a
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->e()B

    move-result v1

    const/16 v4, 0xf

    if-ne v1, v4, :cond_b

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    const v1, 0x7f0806f8

    invoke-virtual {v0, v1, v3, v3, v3}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    return-void

    :cond_b
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->e()B

    move-result v1

    const/16 v3, 0x10

    const v4, 0x7f0f0651

    if-ne v1, v3, :cond_c

    :goto_3
    invoke-static {v4}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v7

    goto :goto_5

    :cond_c
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->e()B

    move-result v0

    const/16 v1, 0x11

    if-ne v0, v1, :cond_e

    goto :goto_3

    :cond_d
    :goto_4
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    const v1, 0x7f080745

    invoke-virtual {v0, v1, v3, v3, v3}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    return-void

    :cond_e
    :goto_5
    invoke-static {v7}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_f

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_6
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_f
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->e:Landroid/widget/TextView;

    const-string v1, ""
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_6

    :catch_2
    return-void
.end method

.method private d()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->S:Lchat/ola/vn/message/d;

    const/16 v1, 0x8

    if-eqz v0, :cond_4

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->d()B

    move-result v2

    const/4 v3, 0x2

    if-eq v2, v3, :cond_1

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Lchat/ola/vn/message/d;->q()B

    move-result v0

    const v2, 0x7f08069a

    const/4 v4, 0x0

    packed-switch v0, :pswitch_data_0

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    if-ne v0, v3, :cond_3

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    :cond_3
    return-void

    :cond_4
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->b:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :pswitch_data_0
    .packed-switch 0x2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private e()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x2

    if-eq v0, v1, :cond_2

    const/4 v1, 0x4

    if-eq v0, v1, :cond_1

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/message/n$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f080679

    :goto_0
    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->o()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v0, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->o()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/message/n$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v4, 0x7f080692

    const/16 v5, 0x60

    const/4 v6, 0x1

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;IIZ)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/message/n$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f080692

    goto :goto_0

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/f;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    if-nez p1, :cond_0

    return-void

    :cond_0
    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/message/n$a;->i:Landroid/view/View;

    const/4 p2, 0x4

    :goto_0
    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/message/n$a;->i:Landroid/view/View;

    const/4 p2, 0x0

    goto :goto_0

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    const/4 p2, 0x5

    if-ne p1, p2, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/message/n$a;->b()V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    const/4 p2, 0x7

    if-ne p1, p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/message/n$a;->g:Lchat/ola/vn/message/f;

    check-cast p1, Lchat/ola/vn/message/o;

    invoke-direct {p0, p1}, Lchat/ola/vn/message/n$a;->a(Lchat/ola/vn/message/o;)V

    return-void

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/message/n$a;->a()V

    return-void
.end method
