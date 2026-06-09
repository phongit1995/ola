.class public Lchat/ola/vn/entry/b/n;
.super Lchat/ola/vn/entry/b/l;


# instance fields
.field private a:Landroid/view/View;

.field private e:Landroid/view/View;

.field private f:Landroid/view/View;

.field private g:Landroid/view/View;

.field private h:Lchat/ola/vn/entry/d;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/l;-><init>(Landroid/view/View;)V

    const v0, 0x7f090413

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/n;->a:Landroid/view/View;

    const v0, 0x7f090414

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/n;->e:Landroid/view/View;

    const v0, 0x7f090415

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/n;->f:Landroid/view/View;

    const v0, 0x7f0905e7

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b/n;->g:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;I)V
    .locals 1

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0, p2, p1, p3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a(Landroid/view/View;Lchat/ola/vn/entity/ad;)V
    .locals 6

    const v0, 0x7f09056e

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f09056c

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    const v2, 0x7f0904a3

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    const v3, 0x7f09029e

    invoke-virtual {p1, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    sget v3, Lchat/ola/vn/e;->c:I

    sget v4, Lchat/ola/vn/e;->d:I

    invoke-static {v3, v4}, Ljava/lang/Math;->max(II)I

    move-result v3

    invoke-virtual {p2}, Lchat/ola/vn/entity/ad;->p()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p2}, Lchat/ola/vn/entity/ad;->n()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/16 v4, 0x8

    const/4 v5, 0x0

    if-nez v0, :cond_1

    if-eqz v2, :cond_0

    invoke-virtual {v2, v5}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    if-eqz v1, :cond_3

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-virtual {p2}, Lchat/ola/vn/entity/ad;->n()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    if-eqz v2, :cond_2

    invoke-virtual {v2, v4}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    if-eqz v1, :cond_3

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_3
    :goto_0
    invoke-virtual {p2}, Lchat/ola/vn/entity/ad;->h()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    invoke-virtual {p1, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-direct {p0, p1, p2, v3}, Lchat/ola/vn/entry/b/n;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;I)V

    return-void

    :cond_4
    invoke-virtual {p1, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/entry/c;I)V
    .locals 2

    :try_start_0
    check-cast p1, Lchat/ola/vn/entry/d;

    iput-object p1, p0, Lchat/ola/vn/entry/b/n;->h:Lchat/ola/vn/entry/d;

    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->h:Lchat/ola/vn/entry/d;

    const/16 p2, 0x8

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->h:Lchat/ola/vn/entry/d;

    iget-object p1, p1, Lchat/ola/vn/entry/d;->b:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-nez p1, :cond_0

    goto/16 :goto_7

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->h:Lchat/ola/vn/entry/d;

    iget-object p1, p1, Lchat/ola/vn/entry/d;->b:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    const/4 v0, 0x0

    packed-switch p1, :pswitch_data_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->a:Landroid/view/View;

    goto :goto_1

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->a:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->e:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->f:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_2

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->a:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->e:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :goto_1
    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->e:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->f:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :goto_2
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->g:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/n;->h:Lchat/ola/vn/entry/d;

    iget-object v1, v1, Lchat/ola/vn/entry/d;->c:Ljava/lang/String;

    invoke-virtual {p1, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->g:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/n;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->h:Lchat/ola/vn/entry/d;

    iget-object p1, p1, Lchat/ola/vn/entry/d;->c:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->g:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_3

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->g:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    :goto_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->h:Lchat/ola/vn/entry/d;

    iget-object p1, p1, Lchat/ola/vn/entry/d;->b:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    :goto_4
    if-ge v0, p1, :cond_3

    iget-object p2, p0, Lchat/ola/vn/entry/b/n;->h:Lchat/ola/vn/entry/d;

    iget-object p2, p2, Lchat/ola/vn/entry/d;->b:Ljava/util/List;

    invoke-interface {p2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/entity/ad;

    packed-switch v0, :pswitch_data_1

    goto :goto_6

    :pswitch_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/n;->f:Landroid/view/View;

    invoke-virtual {p0, v1, p2}, Lchat/ola/vn/entry/b/n;->a(Landroid/view/View;Lchat/ola/vn/entity/ad;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :try_start_3
    iget-object v1, p0, Lchat/ola/vn/entry/b/n;->f:Landroid/view/View;

    invoke-virtual {v1, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/n;->f:Landroid/view/View;

    :goto_5
    iget-object v1, p0, Lchat/ola/vn/entry/b/n;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p2, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_6

    :pswitch_3
    :try_start_4
    iget-object v1, p0, Lchat/ola/vn/entry/b/n;->e:Landroid/view/View;

    invoke-virtual {p0, v1, p2}, Lchat/ola/vn/entry/b/n;->a(Landroid/view/View;Lchat/ola/vn/entity/ad;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    :try_start_5
    iget-object v1, p0, Lchat/ola/vn/entry/b/n;->e:Landroid/view/View;

    invoke-virtual {v1, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/n;->e:Landroid/view/View;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_1

    goto :goto_5

    :pswitch_4
    :try_start_6
    iget-object v1, p0, Lchat/ola/vn/entry/b/n;->a:Landroid/view/View;

    invoke-virtual {p0, v1, p2}, Lchat/ola/vn/entry/b/n;->a(Landroid/view/View;Lchat/ola/vn/entity/ad;)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_2

    :try_start_7
    iget-object v1, p0, Lchat/ola/vn/entry/b/n;->a:Landroid/view/View;

    invoke-virtual {v1, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/n;->a:Landroid/view/View;
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_1

    goto :goto_5

    :catch_1
    :goto_6
    add-int/lit8 v0, v0, 0x1

    goto :goto_4

    :cond_2
    :goto_7
    :try_start_8
    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->a:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->e:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/n;->f:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_2

    :catch_2
    :cond_3
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method
