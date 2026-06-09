.class public Lchat/ola/vn/entry/b/a/a;
.super Lchat/ola/vn/entry/b/a/b;


# instance fields
.field private e:Lchat/ola/vn/view/OlaRatioImageView;

.field private f:Lchat/ola/vn/view/OlaCachedImageView;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/widget/TextView;

.field private j:Landroid/widget/TextView;

.field private k:Landroid/view/View;

.field private l:Landroid/view/View;

.field private m:Landroid/widget/TextView;

.field private n:Landroid/widget/TextView;

.field private o:Landroid/widget/ProgressBar;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/view/ViewGroup;Landroid/view/View$OnClickListener;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/entry/b/a/b;-><init>(Landroid/content/Context;Landroid/view/ViewGroup;Landroid/view/View$OnClickListener;)V

    const p3, 0x7f0b0023

    :try_start_0
    invoke-static {p1, p3, p2}, Landroid/view/View;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f090072

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    const p2, 0x7f090078

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/a;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const p2, 0x7f090075

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/a;->g:Landroid/widget/TextView;

    const p2, 0x7f090071

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/a;->h:Landroid/widget/TextView;

    const p2, 0x7f090077

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/a;->i:Landroid/widget/TextView;

    const p2, 0x7f090076

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/a;->j:Landroid/widget/TextView;

    const p2, 0x7f090073

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ProgressBar;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/a;->o:Landroid/widget/ProgressBar;

    const p2, 0x7f09007e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/a;->l:Landroid/view/View;

    const p2, 0x7f090074

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    const p2, 0x7f09007d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/a;->m:Landroid/widget/TextView;

    const p2, 0x7f09033f

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/entry/b/a/a;->n:Landroid/widget/TextView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a()B
    .locals 1

    const/4 v0, 0x2

    return v0
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/ProgressBar;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/a;->o:Landroid/widget/ProgressBar;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/a;->g:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/a;->h:Landroid/widget/TextView;

    return-object p0
.end method

.method private c()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v0, v0, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/a;->f:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/entry/b/a/a;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    return-object p0
.end method

.method private d()V
    .locals 4
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->l:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    const-wide v2, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setBackgroundColor(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->p:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v0, v0, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->m:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->m:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->n:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->m:Landroid/widget/TextView;

    const-string v1, "--:--"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->n:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->o:Ljava/lang/String;

    new-instance v2, Lchat/ola/vn/entry/b/a/a$2;

    invoke-direct {v2, p0}, Lchat/ola/vn/entry/b/a/a$2;-><init>(Lchat/ola/vn/entry/b/a/a;)V

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/b;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method static synthetic e(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/a;->i:Landroid/widget/TextView;

    return-object p0
.end method

.method private e()V
    .locals 4
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->l:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    const-wide v2, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setBackgroundColor(I)V

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://img.youtube.com/vi/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->n:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "/mqdefault.jpg"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaRatioImageView;->getWidth()I

    move-result v1

    const/16 v2, 0x190

    if-le v1, v2, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://img.youtube.com/vi/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->n:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "/hqdefault.jpg"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v0, v0, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->n:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->m:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->m:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->n:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->m:Landroid/widget/TextView;

    const-string v1, "--:--"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance v0, Lchat/ola/vn/entry/b/a/a$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/entry/b/a/a$3;-><init>(Lchat/ola/vn/entry/b/a/a;)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v2, v2, Lchat/ola/vn/entity/f;->n:Ljava/lang/String;

    invoke-virtual {v1, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/o;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method private f()V
    .locals 6

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->l:Landroid/view/View;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaRatioImageView;->getVisibility()I

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v1

    const-wide v2, 0x4015555555555555L    # 5.333333333333333

    packed-switch v1, :pswitch_data_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    goto :goto_1

    :pswitch_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    sget-object v4, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v4}, Lchat/ola/vn/view/OlaRatioImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    const-wide/high16 v4, 0x3ff0000000000000L    # 1.0

    invoke-virtual {v1, v4, v5}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setBackgroundColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    const v1, 0x7f080717

    :goto_0
    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setImageResource(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_2

    return-void

    :pswitch_1
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->l:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :try_start_3
    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    const-wide v1, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    sget v1, Lchat/ola/vn/f;->h:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setBackgroundColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaRatioImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->n:Landroid/widget/TextView;

    const v1, 0x7f0f064e

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->m:Landroid/widget/TextView;

    const-string v1, "--:--"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :pswitch_2
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v3}, Lchat/ola/vn/view/OlaRatioImageView;->getWidth()I

    move-result v3

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    return-void

    :goto_1
    sget-object v4, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v4}, Lchat/ola/vn/view/OlaRatioImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setBackgroundColor(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    const v1, 0x7f080775

    goto :goto_0

    :catch_2
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic f(Lchat/ola/vn/entry/b/a/a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/a;->c()V

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/entry/b/a/a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/a;->f()V

    return-void
.end method

.method static synthetic h(Lchat/ola/vn/entry/b/a/a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/a;->d()V

    return-void
.end method

.method static synthetic i(Lchat/ola/vn/entry/b/a/a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/a;->e()V

    return-void
.end method

.method static synthetic j(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/a;->j:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic k(Lchat/ola/vn/entry/b/a/a;)Lchat/ola/vn/view/OlaRatioImageView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/a;->e:Lchat/ola/vn/view/OlaRatioImageView;

    return-object p0
.end method

.method static synthetic l(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/a;->n:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic m(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/a;->m:Landroid/widget/TextView;

    return-object p0
.end method


# virtual methods
.method public a(Lchat/ola/vn/entry/b/ab;)V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    const/4 v1, 0x0

    const/16 v2, 0x8

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->o:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->g:Landroid/widget/TextView;

    const-string v2, ""

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->h:Landroid/widget/TextView;

    const-string v2, ""

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->c:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->x()Lchat/ola/vn/entity/h;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/h;->a()J

    move-result-wide v1

    new-instance v3, Lchat/ola/vn/entry/b/a/a$1;

    invoke-direct {v3, p0, p1}, Lchat/ola/vn/entry/b/a/a$1;-><init>(Lchat/ola/vn/entry/b/a/a;Lchat/ola/vn/entry/b/ab;)V

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->a(JLchat/ola/vn/p/c;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-boolean v0, v0, Lchat/ola/vn/entity/f;->a:Z

    if-nez v0, :cond_9

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->o:Landroid/widget/ProgressBar;

    invoke-virtual {p1, v2}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->c:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->c:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->i:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->i:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->g:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v0, v0, Lchat/ola/vn/entity/f;->q:Ljava/lang/CharSequence;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->h:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v0, v0, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/a;->c()V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_1

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/a;->f()V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/f;->o:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/a;->d()V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/f;->n:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_3

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/a;->e()V

    goto :goto_0

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->k:Landroid/view/View;

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->i:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->r:I

    const/4 v0, 0x1

    if-lez p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1}, Lchat/ola/vn/entity/f;->a()Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->i:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->H:I

    :goto_1
    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_2

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->i:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->z:I

    goto :goto_1

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->r:I

    if-le p1, v0, :cond_5

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->i:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v4, v4, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v4, v4, Lchat/ola/vn/entity/f;->r:I

    int-to-long v4, v4

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v4, 0x7f0f0538

    :goto_3
    invoke-static {v4}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->i:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v4, v4, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v4, v4, Lchat/ola/vn/entity/f;->r:I

    int-to-long v4, v4

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v4, 0x7f0f0539

    goto :goto_3

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->i:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->z:I

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->i:Landroid/widget/TextView;

    const v3, 0x7f0f0536

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setText(I)V

    :goto_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->t:I

    if-lez p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->j:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->t:I

    if-le p1, v0, :cond_7

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->j:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v1, v1, Lchat/ola/vn/entity/f;->t:I

    int-to-long v1, v1

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f0487

    :goto_5
    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->j:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v1, v1, Lchat/ola/vn/entity/f;->t:I

    int-to-long v1, v1

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v1, 0x7f0f0486

    goto :goto_5

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a;->j:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_9
    invoke-virtual {p1}, Lchat/ola/vn/entry/b/ab;->g()V

    return-void
.end method

.method public a(B)Z
    .locals 1

    const/4 v0, 0x2

    if-ne v0, p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method b(Lchat/ola/vn/entry/b/ab;)V
    .locals 0

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/ab;->g()V

    return-void
.end method
