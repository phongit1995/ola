.class public Lchat/ola/vn/entry/b/f;
.super Lchat/ola/vn/entry/b/b;


# static fields
.field public static s:Lchat/ola/vn/entry/b/f;


# instance fields
.field protected f:Lchat/ola/vn/view/OlaCachedImageView;

.field protected g:Lchat/ola/vn/view/OlaCachedImageView;

.field protected h:Landroid/widget/TextView;

.field protected i:Lcom/mg/ola/common/widget/OlaTextView;

.field protected j:Landroid/view/View;

.field protected k:Landroid/view/View;

.field protected l:Landroid/view/View;

.field protected m:Landroid/view/View;

.field protected n:Landroid/widget/TextView;

.field protected o:Landroid/widget/LinearLayout;

.field protected p:Landroid/view/View;

.field protected q:Landroid/view/ViewStub;

.field protected r:Landroid/widget/TextView;

.field private t:Lchat/ola/vn/message/d;

.field private u:Z

.field private v:Z

.field private w:Landroid/view/animation/Animation;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/view/View;)V
    .locals 2

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/b;-><init>(Landroid/view/View;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/entry/b/f;->u:Z

    iput-boolean v0, p0, Lchat/ola/vn/entry/b/f;->v:Z

    const v0, 0x7f090156

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->o:Landroid/widget/LinearLayout;

    const v0, 0x7f090150

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewStub;

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->q:Landroid/view/ViewStub;

    const v0, 0x7f090158

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    new-instance v1, Lchat/ola/vn/entry/b/f$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/entry/b/f$1;-><init>(Lchat/ola/vn/entry/b/f;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090356

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->p:Landroid/view/View;

    const v0, 0x7f090355

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    const v0, 0x7f090468

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f090403

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09041c

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->j:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->j:Landroid/view/View;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->j:Landroid/view/View;

    new-instance v1, Lchat/ola/vn/entry/b/f$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/entry/b/f$2;-><init>(Lchat/ola/vn/entry/b/f;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_0
    const v0, 0x7f090469

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->l:Landroid/view/View;

    const v0, 0x7f09020d

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->n:Landroid/widget/TextView;

    const v0, 0x7f090359

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/common/widget/OlaTextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->i:Lcom/mg/ola/common/widget/OlaTextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->i:Lcom/mg/ola/common/widget/OlaTextView;

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaTextView;->setOlaSpanClickListener(Lcom/mg/ola/common/widget/OlaTextView$b;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_2
    const v0, 0x7f090159

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->h:Landroid/widget/TextView;

    const v0, 0x7f090092

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->m:Landroid/view/View;

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    const v0, 0x7f010021

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b/f;->w:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->w:Landroid/view/animation/Animation;

    const-wide/16 v0, 0x12c

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/f;)Lchat/ola/vn/message/d;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    return-object p0
.end method

.method private a(Z)V
    .locals 4

    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->u:Z

    const/4 v1, 0x0

    const/16 v2, 0x8

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->h:Landroid/widget/TextView;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    :goto_0
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_1

    :cond_1
    iget-boolean p1, p0, Lchat/ola/vn/entry/b/f;->u:Z

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->h:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_1

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->h:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    if-eqz p1, :cond_4

    iget-boolean p1, p0, Lchat/ola/vn/entry/b/f;->u:Z

    if-nez p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    invoke-virtual {p1}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_4
    :goto_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    const/4 v0, 0x1

    if-eq p1, v0, :cond_5

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    goto :goto_3

    :cond_5
    iget-boolean p1, p0, Lchat/ola/vn/entry/b/f;->u:Z

    if-nez p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    goto :goto_3

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v3, 0x4

    invoke-virtual {p1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :cond_7
    :goto_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    const/4 v3, 0x2

    if-ne p1, v3, :cond_9

    iget-boolean p1, p0, Lchat/ola/vn/entry/b/f;->v:Z

    if-nez p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->q()B

    move-result p1

    packed-switch p1, :pswitch_data_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaCachedImageView;->getVisibility()I

    move-result p1

    if-eq p1, v2, :cond_b

    goto :goto_4

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaCachedImageView;->getVisibility()I

    move-result p1

    if-eqz p1, :cond_b

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->w:Landroid/view/animation/Animation;

    invoke-virtual {p1}, Landroid/view/animation/Animation;->cancel()V

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->w:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaCachedImageView;->getVisibility()I

    move-result p1

    if-eq p1, v2, :cond_b

    :goto_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_9
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result p1

    if-ne p1, v0, :cond_a

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaCachedImageView;->getVisibility()I

    move-result p1

    if-eq p1, v2, :cond_b

    goto :goto_4

    :cond_a
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/view/OlaCachedImageView;->getVisibility()I

    move-result p1

    if-eq p1, v2, :cond_b

    goto :goto_4

    :catch_0
    :cond_b
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method private g()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->q()B

    move-result v0

    const v1, 0x7f08069a

    const/4 v2, 0x0

    packed-switch v0, :pswitch_data_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    goto :goto_1

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0, v2}, Lchat/ola/vn/message/d;->a(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/entry/b/f;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    goto :goto_1

    :cond_0
    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    goto :goto_0

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f080728

    :goto_0
    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    :goto_1
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->d()B

    move-result v0

    const/4 v1, 0x2

    const/16 v3, 0x8

    if-ne v0, v1, :cond_a

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->q()B

    move-result v0

    const/4 v1, 0x4

    if-ne v0, v1, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->l:Landroid/view/View;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->l:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->j:Landroid/view/View;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->j:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->n:Landroid/widget/TextView;

    if-eqz v0, :cond_d

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->n:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->q()B

    move-result v0

    const/4 v1, 0x5

    if-ne v0, v1, :cond_7

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->l:Landroid/view/View;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->l:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->j:Landroid/view/View;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->j:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->n:Landroid/widget/TextView;

    if-eqz v0, :cond_d

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->A()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->n:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v1}, Lchat/ola/vn/message/d;->A()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->n:Landroid/widget/TextView;

    const v1, 0x7f0f025d

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    :goto_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->n:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_7
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->l:Landroid/view/View;

    if-eqz v0, :cond_8

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->l:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_8
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->j:Landroid/view/View;

    if-eqz v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->j:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_9
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->n:Landroid/widget/TextView;

    if-eqz v0, :cond_d

    goto :goto_2

    :cond_a
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->l:Landroid/view/View;

    if-eqz v0, :cond_b

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->l:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_b
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->j:Landroid/view/View;

    if-eqz v0, :cond_c

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->j:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_c
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->n:Landroid/widget/TextView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_d

    goto :goto_2

    :catch_0
    :cond_d
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private h()V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->h:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v1}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->setTimeInMillis(J)V

    const/16 v1, 0xb

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v1

    const/16 v2, 0xc

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0xa

    if-ge v1, v4, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "0"

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :cond_0
    if-ge v0, v4, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "0"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->h:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a()V
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/entry/b/f;->u:Z

    iput-boolean v0, p0, Lchat/ola/vn/entry/b/f;->v:Z

    return-void
.end method

.method protected a(Lchat/ola/vn/message/d;)V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->i:Lcom/mg/ola/common/widget/OlaTextView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/message/d;->d()B

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x4

    const/4 v3, 0x0

    if-ne v0, v1, :cond_4

    iget-boolean v0, p1, Lchat/ola/vn/message/d;->w:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->i:Lcom/mg/ola/common/widget/OlaTextView;

    sget v1, Lchat/ola/vn/f;->A:I

    :goto_0
    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaTextView;->setTextColor(I)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->i:Lcom/mg/ola/common/widget/OlaTextView;

    sget v1, Lchat/ola/vn/f;->y:I

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->m:Landroid/view/View;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->m:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->m:Landroid/view/View;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->m:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_2
    iget-boolean v0, p1, Lchat/ola/vn/message/d;->x:Z

    if-eqz v0, :cond_3

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->m:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    goto :goto_5

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->m:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_5

    :cond_4
    iget-boolean v0, p1, Lchat/ola/vn/message/d;->w:Z

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->i:Lcom/mg/ola/common/widget/OlaTextView;

    sget v1, Lchat/ola/vn/f;->E:I

    :goto_3
    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaTextView;->setTextColor(I)V

    goto :goto_4

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->i:Lcom/mg/ola/common/widget/OlaTextView;

    sget v1, Lchat/ola/vn/f;->C:I

    goto :goto_3

    :goto_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->m:Landroid/view/View;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->m:Landroid/view/View;

    invoke-virtual {v0, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->m:Landroid/view/View;

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->m:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_6
    iget-boolean v0, p1, Lchat/ola/vn/message/d;->x:Z

    if-eqz v0, :cond_3

    goto :goto_2

    :cond_7
    :goto_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->i:Lcom/mg/ola/common/widget/OlaTextView;

    invoke-virtual {p1}, Lchat/ola/vn/message/d;->l()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/mg/ola/common/widget/OlaTextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method public a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 7

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->b:Landroid/view/View$OnLongClickListener;

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    const/4 p1, 0x1

    const/4 v0, 0x0

    :try_start_1
    iput-boolean v0, p0, Lchat/ola/vn/entry/b/f;->u:Z

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->d()B

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v2}, Lchat/ola/vn/message/d;->d()B

    move-result v2

    if-ne v1, v2, :cond_0

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v2}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v1}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v1

    invoke-virtual {p2}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v3

    const/4 p2, 0x0

    sub-long v5, v1, v3

    invoke-static {v5, v6}, Ljava/lang/Math;->abs(J)J

    move-result-wide v1

    const-wide/32 v3, 0x493e0

    cmp-long p2, v1, v3

    if-gez p2, :cond_0

    iput-boolean p1, p0, Lchat/ola/vn/entry/b/f;->u:Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_0
    :try_start_2
    iput-boolean v0, p0, Lchat/ola/vn/entry/b/f;->v:Z

    invoke-virtual {p3}, Lchat/ola/vn/message/d;->d()B

    move-result p2

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v1}, Lchat/ola/vn/message/d;->d()B

    move-result v1

    if-ne p2, v1, :cond_1

    invoke-virtual {p3}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object p2

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v1}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v1

    invoke-static {p2, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    invoke-virtual {p3}, Lchat/ola/vn/message/d;->m()J

    move-result-wide p2

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v1}, Lchat/ola/vn/message/d;->m()J

    move-result-wide v1

    const/4 v3, 0x0

    sub-long v3, p2, v1

    invoke-static {v3, v4}, Ljava/lang/Math;->abs(J)J

    move-result-wide p2

    const-wide/32 v1, 0x2bf20

    cmp-long v3, p2, v1

    if-gez v3, :cond_1

    iput-boolean p1, p0, Lchat/ola/vn/entry/b/f;->v:Z
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    :try_start_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {p0, p1}, Lchat/ola/vn/entry/b/f;->a(Lchat/ola/vn/message/d;)V

    invoke-virtual {p0}, Lchat/ola/vn/entry/b/f;->e()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/f;->h()V

    invoke-virtual {p0}, Lchat/ola/vn/entry/b/f;->f()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/f;->g()V

    invoke-direct {p0, v0}, Lchat/ola/vn/entry/b/f;->a(Z)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    return-void

    :catch_2
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method

.method public b()Landroid/view/View;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    return-object v0

    :cond_0
    invoke-super {p0}, Lchat/ola/vn/entry/b/b;->b()Landroid/view/View;

    move-result-object v0

    return-object v0
.end method

.method public c()V
    .locals 2

    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->u:Z

    const/16 v1, 0x8

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->h:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_0
    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->v:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaCachedImageView;->getVisibility()I

    move-result v0

    if-eq v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :cond_1
    return-void
.end method

.method public d()V
    .locals 1
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->u:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->h:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-direct {p0, v0}, Lchat/ola/vn/entry/b/f;->a(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected e()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->p:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->d()B

    move-result v0

    const/4 v1, 0x0

    packed-switch v0, :pswitch_data_0

    goto/16 :goto_1

    :pswitch_0
    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->u:Z

    const/4 v2, 0x5

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->v:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->p:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->q()B

    move-result v0

    if-ne v0, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f080156

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundResource(I)V

    goto/16 :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f080154

    goto :goto_0

    :cond_1
    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->v:Z

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->q()B

    move-result v0

    if-ne v0, v2, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f080157

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f080155

    goto :goto_0

    :cond_3
    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->u:Z

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->p:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->q()B

    move-result v0

    if-ne v0, v2, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f080159

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f08015b

    goto :goto_0

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->q()B

    move-result v0

    if-ne v0, v2, :cond_6

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f080158

    goto :goto_0

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f08015a

    goto :goto_0

    :pswitch_1
    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->u:Z

    if-nez v0, :cond_7

    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->v:Z

    if-nez v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->p:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f080150

    goto :goto_0

    :cond_7
    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->v:Z

    if-nez v0, :cond_8

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f080151

    goto :goto_0

    :cond_8
    iget-boolean v0, p0, Lchat/ola/vn/entry/b/f;->u:Z

    if-nez v0, :cond_9

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->p:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f080153

    goto :goto_0

    :cond_9
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v1, 0x7f080152

    goto/16 :goto_0

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    const v1, 0x7f0800dd

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundResource(I)V

    :catch_0
    :goto_1
    iget v0, p0, Lchat/ola/vn/entry/b/f;->e:I

    if-ltz v0, :cond_a

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->k:Landroid/view/View;

    iget v1, p0, Lchat/ola/vn/entry/b/f;->e:I

    iget v2, p0, Lchat/ola/vn/entry/b/f;->e:I

    iget v3, p0, Lchat/ola/vn/entry/b/f;->e:I

    iget v4, p0, Lchat/ola/vn/entry/b/f;->e:I

    invoke-virtual {v0, v1, v2, v3, v4}, Landroid/view/View;->setPadding(IIII)V

    :cond_a
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method protected f()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->d()B

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_6

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v0}, Lchat/ola/vn/message/d;->i()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_6

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-boolean v1, p0, Lchat/ola/vn/entry/b/f;->u:Z

    if-nez v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/entry/b/f;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    goto :goto_0

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    :cond_3
    :goto_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->t:Lchat/ola/vn/message/d;

    invoke-virtual {v1}, Lchat/ola/vn/message/d;->f()Lchat/ola/vn/message/f;

    move-result-object v1

    if-eqz v1, :cond_6

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    const/4 v2, 0x2

    if-eq v1, v2, :cond_4

    const/4 v2, 0x4

    if-eq v1, v2, :cond_4

    return-void

    :cond_4
    :try_start_0
    iget-boolean v1, p0, Lchat/ola/vn/entry/b/f;->u:Z

    if-nez v1, :cond_6

    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/message/g;->f(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v1

    if-eqz v1, :cond_5

    iget-object v0, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-interface {v1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_5
    iget-object v1, p0, Lchat/ola/vn/entry/b/f;->r:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_6
    return-void
.end method
