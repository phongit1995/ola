.class public Lchat/ola/vn/g/k;
.super Lchat/ola/vn/g/h;


# instance fields
.field public e:Lchat/ola/vn/view/OlaCachedImageView;

.field public f:Lchat/ola/vn/view/OlaCachedImageView;

.field public g:Landroid/widget/TextView;

.field public h:Landroid/widget/TextView;

.field public i:Landroid/widget/TextView;

.field public j:Landroid/widget/ImageView;

.field public k:Z

.field public l:Z

.field private m:Landroid/view/View;

.field private n:I

.field private o:Lchat/ola/vn/message/f;

.field private p:Landroid/widget/ImageView;

.field private q:Lchat/ola/vn/view/OlaCachedImageView;

.field private r:Z


# direct methods
.method public constructor <init>(Lchat/ola/vn/message/f;Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p2}, Lchat/ola/vn/g/h;-><init>(Landroid/view/View;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/g/k;->k:Z

    iput-boolean v0, p0, Lchat/ola/vn/g/k;->l:Z

    iput-boolean v0, p0, Lchat/ola/vn/g/k;->r:Z

    iput-object p2, p0, Lchat/ola/vn/g/k;->m:Landroid/view/View;

    iput-object p1, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    const p1, 0x7f090281

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/g/k;->e:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f090273

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    const p1, 0x7f090297

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/g/k;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f09052a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/g/k;->g:Landroid/widget/TextView;

    const p1, 0x7f0904cb

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/g/k;->h:Landroid/widget/TextView;

    const p1, 0x7f090529

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/g/k;->i:Landroid/widget/TextView;

    const p1, 0x7f090279

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/g/k;->p:Landroid/widget/ImageView;

    const p1, 0x7f0905f2

    :try_start_0
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/g/k;->q:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const p2, 0x7f070133

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/g/k;->n:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/g/k;)Lchat/ola/vn/message/f;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    return-object p0
.end method

.method private a(Landroid/view/View$OnClickListener;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/g/k;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->m()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/g/k;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/g/k;->e:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v0, 0x1

    :goto_0
    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setClickable(Z)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/g/k;->e:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/g/k;->e:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v0, 0x0

    goto :goto_0

    :cond_2
    return-void
.end method

.method private c()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/g/k;->l:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/g/k;->p:Landroid/widget/ImageView;

    const/16 v1, 0x8

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x4

    if-eq v0, v1, :cond_5

    packed-switch v0, :pswitch_data_0

    iget-object v0, p0, Lchat/ola/vn/g/k;->p:Landroid/widget/ImageView;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->r()B

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_2

    iget-object v0, p0, Lchat/ola/vn/g/k;->p:Landroid/widget/ImageView;

    const v1, 0x7f0806da

    :goto_1
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->r()B

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/g/k;->p:Landroid/widget/ImageView;

    const v1, 0x7f0806d6

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->r()B

    move-result v0

    const/4 v2, 0x2

    if-ne v0, v2, :cond_4

    iget-object v0, p0, Lchat/ola/vn/g/k;->p:Landroid/widget/ImageView;

    const v1, 0x7f0806d4

    goto :goto_1

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/g/k;->p:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void

    :cond_5
    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->p:Landroid/widget/ImageView;

    goto :goto_0

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method private d()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->e:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x2

    if-eq v0, v1, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/g/k;->f()V

    iget-boolean v0, p0, Lchat/ola/vn/g/k;->k:Z

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/g/k;->k()V

    return-void

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/g/k;->j()V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->q:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/g/k;->q:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/g/k;->e()V

    return-void
.end method

.method private e()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->o()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->o()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/g/k;->e:Lchat/ola/vn/view/OlaCachedImageView;

    const v4, 0x7f080692

    const/16 v5, 0x60

    const/4 v6, 0x1

    invoke-virtual/range {v1 .. v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;IIZ)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->e:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f080692

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void
.end method

.method private f()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/g/k;->l()V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/g/k;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method

.method private g()V
    .locals 8

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->g:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->h:Landroid/widget/TextView;

    if-eqz v0, :cond_2

    const/16 v0, 0x8

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    iget-wide v1, v1, Lchat/ola/vn/message/f;->N:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-lez v5, :cond_1

    iget-object v1, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->g()S

    move-result v1

    const/4 v2, 0x2

    if-eq v1, v2, :cond_1

    iget-object v1, p0, Lchat/ola/vn/g/k;->h:Landroid/widget/TextView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/g/k;->h:Landroid/widget/TextView;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-object v4, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    iget-wide v4, v4, Lchat/ola/vn/message/f;->N:J

    const/4 v6, 0x0

    sub-long v6, v2, v4

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/b;->c()[Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object v3

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/b;->b()[Ljava/lang/String;

    move-result-object v4

    invoke-static {v6, v7, v2, v3, v4}, Lcom/mg/ola/common/d/i;->a(J[Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/g/k;->h:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    iget-object v1, p0, Lchat/ola/vn/g/k;->h:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_2
    return-void
.end method

.method private h()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->M()Ljava/lang/CharSequence;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->M()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/g/k;->i:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->i:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->M()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->i:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method private i()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f0800d3

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setBackgroundResource(I)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/16 v1, 0x8

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/g/k;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/g/k;->f:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v2, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->R:Ljava/lang/String;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->R:Ljava/lang/String;

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v2, 0x50

    if-eq v0, v2, :cond_2

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/g/k;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    iget-object v1, v1, Lchat/ola/vn/message/f;->R:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/g/k;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const v3, 0x7f080714

    iget v4, p0, Lchat/ola/vn/g/k;->n:I

    invoke-virtual {v0, v1, v2, v3, v4}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;II)V

    return-void

    :cond_3
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void
.end method

.method private j()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x4

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v0

    const-wide/16 v3, 0x0

    cmp-long v5, v0, v3

    const/4 v0, 0x0

    if-eqz v5, :cond_2

    iget-object v1, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    const v1, 0x7f08067a

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->g()S

    move-result v1

    const/4 v3, 0x2

    if-ne v1, v3, :cond_3

    iget-object v1, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    const v1, 0x7f08069a

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void
.end method

.method private k()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x4

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v0

    const-wide/16 v3, 0x0

    cmp-long v5, v0, v3

    const/4 v0, 0x0

    if-eqz v5, :cond_2

    iget-object v1, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    const v1, 0x7f08067a

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->g()S

    move-result v1

    const/4 v3, 0x2

    if-ne v1, v3, :cond_3

    iget-object v1, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->h()S

    move-result v0

    packed-switch v0, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    const v1, 0x7f0806ab

    goto :goto_0

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    const v1, 0x7f0806a7

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    const v1, 0x7f0806a8

    goto :goto_0

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    const v1, 0x7f0806a9

    goto :goto_0

    :pswitch_4
    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    const v1, 0x7f0806aa

    goto :goto_0

    :cond_3
    :goto_1
    iget-object v0, p0, Lchat/ola/vn/g/k;->j:Landroid/widget/ImageView;

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private l()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->q:Lchat/ola/vn/view/OlaCachedImageView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x4

    const/16 v2, 0x8

    if-eq v0, v1, :cond_3

    packed-switch v0, :pswitch_data_0

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->g()S

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    iget-object v0, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->i()S

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/g/k;->q:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/k;->q:Lchat/ola/vn/view/OlaCachedImageView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->i()S

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_4

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->i()S

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/g/k;->q:Lchat/ola/vn/view/OlaCachedImageView;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->i()S

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    return-void

    :cond_2
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->q:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_3
    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/g/k;->q:Lchat/ola/vn/view/OlaCachedImageView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_4

    goto :goto_0

    :catch_0
    :cond_4
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/g/k;->o:Lchat/ola/vn/message/f;

    return-void
.end method

.method public b(I)V
    .locals 1

    :try_start_0
    iget-boolean p1, p0, Lchat/ola/vn/g/k;->r:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/g/k;->m:Landroid/view/View;

    sget v0, Lchat/ola/vn/f;->I:I

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setBackgroundColor(I)V

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/g/k;->m:Landroid/view/View;

    sget v0, Lchat/ola/vn/f;->d:I

    goto :goto_0

    :goto_1
    invoke-direct {p0}, Lchat/ola/vn/g/k;->g()V

    invoke-direct {p0}, Lchat/ola/vn/g/k;->h()V

    invoke-direct {p0}, Lchat/ola/vn/g/k;->d()V

    invoke-direct {p0}, Lchat/ola/vn/g/k;->c()V

    invoke-direct {p0}, Lchat/ola/vn/g/k;->i()V

    new-instance p1, Lchat/ola/vn/g/k$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/g/k$1;-><init>(Lchat/ola/vn/g/k;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/g/k;->a(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public c(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/g/k;->r:Z

    return-void
.end method
