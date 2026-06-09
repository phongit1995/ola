.class public Lchat/ola/vn/entry/b/z;
.super Lchat/ola/vn/entry/b/j;


# instance fields
.field private i:Landroid/content/Context;

.field private j:Lchat/ola/vn/view/OlaRatioImageView;

.field private k:Lchat/ola/vn/view/OlaCachedImageView;

.field private l:Landroid/widget/TextView;

.field private m:Landroid/widget/TextView;

.field private n:Landroid/widget/ImageView;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/j;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/z;->b:Lchat/ola/vn/entry/b;

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x0

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->a:Landroid/view/View$OnClickListener;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    if-eqz v1, :cond_2

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->s()Lchat/ola/vn/entity/d;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move-object v0, v1

    :catch_0
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->n:Landroid/widget/ImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/z;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setTag(Ljava/lang/Object;)V

    if-eqz v0, :cond_1

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->j:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->k:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->l:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->m:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->n:Landroid/widget/ImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/z;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->j:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/z;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->k:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/z;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->l:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/z;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->m:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/entry/b/z;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->y()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    const/4 v2, 0x0

    const/16 v3, 0x8

    if-eqz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->k:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    goto :goto_0

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->k:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v4, p0, Lchat/ola/vn/entry/b/z;->b:Lchat/ola/vn/entry/b;

    iget-object v4, v4, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->y()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/entry/b/z;->k:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v4, v5}, Lchat/ola/vn/c/t;->d(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    :goto_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v4, p0, Lchat/ola/vn/entry/b/z;->b:Lchat/ola/vn/entry/b;

    iget-object v4, v4, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v4}, Lchat/ola/vn/entity/g;->c()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/entry/b/z;->j:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v4, v5}, Lchat/ola/vn/c/t;->d(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_3

    :try_start_3
    invoke-virtual {v0}, Lchat/ola/vn/entity/d;->d()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_4

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->l:Landroid/widget/TextView;

    invoke-virtual {v0}, Lchat/ola/vn/entity/d;->d()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/z;->l:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_1

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/z;->l:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_1

    :catch_1
    :try_start_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/z;->l:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_3

    :goto_1
    :try_start_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/z;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/entry/b/z;->m:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/z;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->b()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/z;->m:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/z;->m:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    return-void

    :catch_2
    :try_start_6
    iget-object v0, p0, Lchat/ola/vn/entry/b/z;->m:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_3

    :catch_3
    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View;)V

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/z;->i:Landroid/content/Context;

    const v0, 0x7f09027a

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/z;->j:Lchat/ola/vn/view/OlaRatioImageView;

    const v0, 0x7f09027b

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/z;->k:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f090546

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/z;->l:Landroid/widget/TextView;

    const v0, 0x7f090545

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/z;->m:Landroid/widget/TextView;

    const v0, 0x7f0900f2

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/entry/b/z;->n:Landroid/widget/ImageView;

    return-void
.end method

.method public d()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/z;->i:Landroid/content/Context;

    return-object v0
.end method
