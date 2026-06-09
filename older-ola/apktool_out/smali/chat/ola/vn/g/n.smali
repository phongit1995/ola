.class public Lchat/ola/vn/g/n;
.super Lchat/ola/vn/g/h;


# instance fields
.field private e:Lchat/ola/vn/view/OlaCachedImageView;

.field private f:Lchat/ola/vn/view/OlaCachedImageView;

.field private g:Lchat/ola/vn/view/OlaCachedImageView;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/view/animation/Animation;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/g/h;-><init>(Landroid/view/View;)V

    const v0, 0x7f0903e4

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/g/n;->e:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f0903e5

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/g/n;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f0903e6

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/g/n;->g:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f090397

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/g/n;->h:Landroid/widget/TextView;

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p1

    const v0, 0x7f010031

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/g/n;->i:Landroid/view/animation/Animation;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Lchat/ola/vn/message/f;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 1

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method

.method private c()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/g/n;->e:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/n;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/g/n;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    const/4 v0, 0x3

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_1

    :try_start_0
    sget-object v3, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v3, v2}, Lchat/ola/vn/message/g;->e(I)Lchat/ola/vn/message/f;

    move-result-object v3

    if-eqz v3, :cond_0

    packed-switch v2, :pswitch_data_0

    return-void

    :pswitch_0
    iget-object v4, p0, Lchat/ola/vn/g/n;->g:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v4, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/g/n;->g:Lchat/ola/vn/view/OlaCachedImageView;

    :goto_1
    invoke-direct {p0, v3, v4}, Lchat/ola/vn/g/n;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/view/OlaCachedImageView;)V

    goto :goto_2

    :pswitch_1
    iget-object v4, p0, Lchat/ola/vn/g/n;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v4, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/g/n;->f:Lchat/ola/vn/view/OlaCachedImageView;

    goto :goto_1

    :pswitch_2
    iget-object v4, p0, Lchat/ola/vn/g/n;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v4, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/g/n;->e:Lchat/ola/vn/view/OlaCachedImageView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_0
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method public b(I)V
    .locals 3

    invoke-direct {p0}, Lchat/ola/vn/g/n;->c()V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->w()I

    move-result p1

    if-lez p1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/g/n;->h:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/g/n;->i:Landroid/view/animation/Animation;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/g/n;->h:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/g/n;->i:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->startAnimation(Landroid/view/animation/Animation;)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/g/n;->h:Landroid/widget/TextView;

    const/4 v0, 0x0

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/g/n;->h:Landroid/widget/TextView;

    const/16 v0, 0x8

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method
