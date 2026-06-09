.class public Lchat/ola/vn/entry/b/ag;
.super Lchat/ola/vn/entry/b/f;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private t:Lchat/ola/vn/view/OlaCachedImageView;

.field private u:Landroid/view/View;

.field private v:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/view/View;I)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ag;->q:Landroid/view/ViewStub;

    invoke-virtual {v0, p2}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/ag;->q:Landroid/view/ViewStub;

    invoke-virtual {p2}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/ag;->q:Landroid/view/ViewStub;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/view/ViewStub;->setVisibility(I)V

    const p2, 0x7f09049c

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ag;->t:Lchat/ola/vn/view/OlaCachedImageView;

    const p2, 0x7f09049e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/ag;->u:Landroid/view/View;

    const p2, 0x7f090036

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b/ag;->v:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->v:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->i:Lcom/mg/ola/common/widget/OlaTextView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setVisibility(I)V

    iput v0, p0, Lchat/ola/vn/entry/b/ag;->e:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/entry/b/f;->a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V

    check-cast p1, Lchat/ola/vn/message/w;

    invoke-virtual {p0, p1}, Lchat/ola/vn/entry/b/ag;->a(Lchat/ola/vn/message/w;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(Lchat/ola/vn/message/w;)V
    .locals 9

    if-nez p1, :cond_0

    return-void

    :cond_0
    :try_start_0
    invoke-virtual {p1}, Lchat/ola/vn/message/w;->a()Lchat/ola/vn/entity/w;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    const/4 v7, 0x0

    const/16 v8, 0x8

    if-nez v1, :cond_6

    const-string v1, "(y)"

    invoke-static {v2, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->u:Landroid/view/View;

    invoke-virtual {p1, v8}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->v:Landroid/view/View;

    invoke-virtual {p1, v8}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->t:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f080861

    :goto_0
    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :cond_1
    const-string v1, ":-*"

    invoke-static {v2, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_5

    const-string v1, ":*"

    invoke-static {v2, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_5

    const-string v1, "\ud83d\udc8b"

    invoke-static {v2, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    goto :goto_2

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/ag;->u:Landroid/view/View;

    invoke-virtual {v1, v7}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v3, p0, Lchat/ola/vn/entry/b/ag;->t:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v4, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    iget-object v5, p0, Lchat/ola/vn/entry/b/ag;->u:Landroid/view/View;

    const/16 v6, 0x1e0

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ag;->t:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v2, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {p1}, Lchat/ola/vn/message/w;->d()B

    move-result p1

    const/4 v1, 0x1

    if-ne p1, v1, :cond_3

    invoke-static {v0}, Lchat/ola/vn/view/i;->b(Lchat/ola/vn/entity/w;)Z

    move-result p1

    if-eqz p1, :cond_4

    :catch_0
    :cond_3
    :goto_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->v:Landroid/view/View;

    invoke-virtual {p1, v8}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->v:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->v:Landroid/view/View;

    invoke-virtual {p1, v7}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_5
    :goto_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->u:Landroid/view/View;

    invoke-virtual {p1, v8}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->v:Landroid/view/View;

    invoke-virtual {p1, v8}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->t:Lchat/ola/vn/view/OlaCachedImageView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const v0, 0x7f080860

    goto :goto_0

    :cond_6
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->u:Landroid/view/View;

    invoke-virtual {p1, v8}, Landroid/view/View;->setVisibility(I)V

    invoke-virtual {v0}, Lchat/ola/vn/entity/w;->c()I

    move-result p1

    if-lez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v7}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/entity/w;->c()I

    move-result v0

    invoke-static {v0}, Lchat/ola/vn/util/c;->a(I)I

    move-result v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    goto :goto_1

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v8}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_1
    return-void
.end method

.method protected e()V
    .locals 5

    invoke-super {p0}, Lchat/ola/vn/entry/b/f;->e()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ag;->k:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundResource(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ag;->k:Landroid/view/View;

    iget v1, p0, Lchat/ola/vn/entry/b/ag;->e:I

    iget v2, p0, Lchat/ola/vn/entry/b/ag;->e:I

    iget v3, p0, Lchat/ola/vn/entry/b/ag;->e:I

    iget v4, p0, Lchat/ola/vn/entry/b/ag;->e:I

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/view/View;->setPadding(IIII)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    const v1, 0x7f090036

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    :try_start_1
    invoke-static {}, Lchat/ola/vn/c/x;->e()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/util/c/a;->z:Landroid/net/Uri;

    invoke-static {v0, v1}, Lchat/ola/vn/util/n;->a(Landroid/content/Context;Landroid/net/Uri;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_1
    :try_start_2
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/w;

    invoke-static {p1}, Lchat/ola/vn/view/i;->a(Lchat/ola/vn/entity/w;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    const v0, 0x7f010024

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    const-wide/16 v0, 0x1f4

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ag;->v:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :try_start_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/ag;->v:Landroid/view/View;

    const/4 v0, 0x4

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    const v0, 0x7f0f0179

    invoke-static {p1, v0}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :catch_2
    return-void
.end method
