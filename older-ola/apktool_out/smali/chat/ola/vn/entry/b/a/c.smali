.class public Lchat/ola/vn/entry/b/a/c;
.super Lchat/ola/vn/entry/b/a/b;


# instance fields
.field private e:Lchat/ola/vn/view/OlaRatioImageView;

.field private f:Landroid/view/View;

.field private g:Landroid/view/View;

.field private h:[Lchat/ola/vn/view/OlaCachedImageView;

.field private i:Landroid/widget/ImageView;

.field private j:Landroid/widget/TextView;

.field private k:Landroid/widget/ImageView;

.field private l:Landroid/widget/TextView;

.field private m:Landroid/view/View;

.field private n:Landroid/view/View;

.field private o:Landroid/view/View;

.field private p:Landroid/view/View;

.field private q:Landroid/widget/TextView;

.field private r:Landroid/widget/TextView;

.field private s:Landroid/widget/TextView;

.field private t:Landroid/widget/ProgressBar;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/view/ViewGroup;Landroid/view/View$OnClickListener;)V
    .locals 1

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/entry/b/a/b;-><init>(Landroid/content/Context;Landroid/view/ViewGroup;Landroid/view/View$OnClickListener;)V

    const p3, 0x7f0b0024

    :try_start_0
    invoke-static {p1, p3, p2}, Landroid/view/View;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f09007a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    const p2, 0x7f09007c

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->q:Landroid/widget/TextView;

    const p2, 0x7f09007b

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ProgressBar;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->t:Landroid/widget/ProgressBar;

    const p2, 0x7f09043a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->f:Landroid/view/View;

    const p2, 0x7f0900f1

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->g:Landroid/view/View;

    const p2, 0x7f09054b

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->i:Landroid/widget/ImageView;

    const p2, 0x7f09054d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->j:Landroid/widget/TextView;

    const p2, 0x7f090548

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->k:Landroid/widget/ImageView;

    const p2, 0x7f090549

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->l:Landroid/widget/TextView;

    const p2, 0x7f09054e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->m:Landroid/view/View;

    const p2, 0x7f0900f7

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->n:Landroid/view/View;

    const p2, 0x7f0900f5

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->o:Landroid/view/View;

    const p2, 0x7f09054a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->p:Landroid/view/View;

    const p2, 0x7f090077

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    const p2, 0x7f090076

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->s:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/a/c;->s:Landroid/widget/TextView;

    new-instance p3, Lchat/ola/vn/entry/b/a/c$1;

    invoke-direct {p3, p0}, Lchat/ola/vn/entry/b/a/c$1;-><init>(Lchat/ola/vn/entry/b/a/c;)V

    invoke-virtual {p2, p3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const/4 p2, 0x3

    new-array p2, p2, [Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 p3, 0x0

    const v0, 0x7f09028f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v0, p2, p3

    iget-object p2, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 p3, 0x1

    const v0, 0x7f090290

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v0, p2, p3

    iget-object p2, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    const/4 p3, 0x2

    const v0, 0x7f090291

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object p1, p2, p3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a()B
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/a/c;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/c;->n:Landroid/view/View;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/ProgressBar;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/c;->t:Landroid/widget/ProgressBar;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/c;->q:Landroid/widget/TextView;

    return-object p0
.end method

.method private c()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->C()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    const/16 v2, 0x8

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v0, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaRatioImageView;->getVisibility()I

    move-result v0

    if-eq v0, v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    :cond_0
    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaRatioImageView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    :cond_2
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v3}, Lchat/ola/vn/view/OlaRatioImageView;->getWidth()I

    move-result v3

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->F()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v0, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaRatioImageView;->getVisibility()I

    move-result v0

    if-eq v0, v2, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    :cond_4
    return-void

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0}, Lchat/ola/vn/view/OlaRatioImageView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    :cond_6
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v1, v1, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_7
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    return-object p0
.end method

.method private d()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->f()I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->z:I

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    const v1, 0x7f080700

    const/4 v2, 0x1

    if-lez v0, :cond_2

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->i()S

    move-result v3

    if-ne v3, v2, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->i:Landroid/widget/ImageView;

    const v3, 0x7f080701

    invoke-virtual {v1, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->j:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->H:I

    :goto_0
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_1

    :cond_0
    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c;->i:Landroid/widget/ImageView;

    invoke-virtual {v3, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->j:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->A:I

    goto :goto_0

    :goto_1
    if-le v0, v2, :cond_1

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v4, v0

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v0, 0x7f0f0538

    :goto_2
    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    int-to-long v4, v0

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v0, 0x7f0f0539

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->i:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->j:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->A:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    :goto_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->E()[Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->E()[Ljava/lang/String;

    move-result-object v0

    array-length v0, v0

    const/16 v1, 0x8

    const/4 v3, 0x2

    const/4 v4, 0x0

    const/4 v5, 0x0

    packed-switch v0, :pswitch_data_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    goto :goto_5

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v5

    invoke-virtual {v0, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v2

    invoke-virtual {v0, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/c;->f()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v3

    invoke-virtual {v0, v4, v4}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v3

    :goto_4
    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v5

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v5

    invoke-virtual {v0, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/c;->f()V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v2

    invoke-virtual {v0, v4, v4}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v3

    invoke-virtual {v0, v4, v4}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v3

    goto :goto_4

    :goto_5
    aget-object v0, v0, v5

    invoke-virtual {v0, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v2

    invoke-virtual {v0, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v3

    invoke-virtual {v0, v5}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/c;->f()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->n:Landroid/view/View;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :catch_0
    :pswitch_2
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method static synthetic e(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/c;->s:Landroid/widget/TextView;

    return-object p0
.end method

.method private e()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->D()I

    move-result v0

    const v1, 0x7f0f04c0

    const v2, 0x7f0806af

    if-lez v0, :cond_1

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->i()S

    move-result v3

    const/4 v4, 0x2

    if-ne v3, v4, :cond_0

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/c;->k:Landroid/widget/ImageView;

    const v3, 0x7f0806ae

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/c;->l:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->y:I

    :goto_0
    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_1

    :cond_0
    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c;->k:Landroid/widget/ImageView;

    invoke-virtual {v3, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/c;->l:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->A:I

    goto :goto_0

    :goto_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/a/c;->l:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " ("

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    int-to-long v0, v0

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ")"

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->k:Landroid/widget/ImageView;

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->l:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->l:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->A:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    return-void
.end method

.method private f()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v2, v2

    if-ge v1, v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v2}, Lchat/ola/vn/entity/g;->E()[Ljava/lang/String;

    move-result-object v2

    array-length v2, v2

    if-ge v1, v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v2, v2, v1

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v2, v2, v1

    invoke-virtual {v2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v3}, Lchat/ola/vn/entity/g;->E()[Ljava/lang/String;

    move-result-object v3

    aget-object v3, v3, v1

    iget-object v4, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v4, v4, v1

    invoke-virtual {v2, v3, v4}, Lchat/ola/vn/c/t;->f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method static synthetic f(Lchat/ola/vn/entry/b/a/c;)[Lchat/ola/vn/view/OlaCachedImageView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    return-object p0
.end method

.method private g()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->d:Landroid/view/View$OnClickListener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->o:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->p:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->n:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->m:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->n:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->m:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->o:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->p:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method static synthetic g(Lchat/ola/vn/entry/b/a/c;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/c;->d()V

    return-void
.end method

.method static synthetic h(Lchat/ola/vn/entry/b/a/c;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/c;->e()V

    return-void
.end method

.method static synthetic i(Lchat/ola/vn/entry/b/a/c;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/c;->g()V

    return-void
.end method

.method static synthetic j(Lchat/ola/vn/entry/b/a/c;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/c;->c()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entry/b/ab;)V
    .locals 9

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->k()S

    move-result v0

    const/16 v1, 0xb

    const/16 v2, 0x8

    const/4 v3, 0x0

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->f:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->g:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->f:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->g:Landroid/view/View;

    const/4 v4, 0x4

    invoke-virtual {v0, v4}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    const/4 v4, 0x2

    const/4 v5, 0x1

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->t:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v3}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->e:Lchat/ola/vn/view/OlaRatioImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaRatioImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->q:Landroid/widget/TextView;

    const-string v6, ""

    invoke-virtual {v0, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->v()J

    move-result-wide v0

    const-wide/16 v6, 0x0

    cmp-long v8, v0, v6

    if-lez v8, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->n:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->v()J

    move-result-wide v1

    new-instance v3, Lchat/ola/vn/entry/b/a/c$2;

    invoke-direct {v3, p0, p1}, Lchat/ola/vn/entry/b/a/c$2;-><init>(Lchat/ola/vn/entry/b/a/c;Lchat/ola/vn/entry/b/ab;)V

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->c(JLchat/ola/vn/p/c;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->C()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->n:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->C()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/entry/b/a/c$3;

    invoke-direct {v2, p0, p1}, Lchat/ola/vn/entry/b/a/c$3;-><init>(Lchat/ola/vn/entry/b/a/c;Lchat/ola/vn/entry/b/ab;)V

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/l;)V

    return-void

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->F()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_d

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->n:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v3

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v5

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v0, v0, v4

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->F()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/entry/b/a/c$4;

    invoke-direct {v2, p0, p1}, Lchat/ola/vn/entry/b/a/c$4;-><init>(Lchat/ola/vn/entry/b/a/c;Lchat/ola/vn/entry/b/ab;)V

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/network/a/a/aj$a;)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-boolean v0, v0, Lchat/ola/vn/entity/f;->a:Z

    if-nez v0, :cond_c

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->F()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->n:Landroid/view/View;

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->n:Landroid/view/View;

    invoke-virtual {p1, v3}, Landroid/view/View;->setVisibility(I)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->t:Landroid/widget/ProgressBar;

    invoke-virtual {p1, v2}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    invoke-virtual {p1, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->q:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object v0, v0, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/c;->c()V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->r:I

    if-lez p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->r:I

    if-le p1, v5, :cond_5

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v6, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v6, v6, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v6, v6, Lchat/ola/vn/entity/f;->r:I

    int-to-long v6, v6

    invoke-static {v6, v7}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, " "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v6, 0x7f0f0538

    :goto_2
    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v6, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v6, v6, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v6, v6, Lchat/ola/vn/entity/f;->r:I

    int-to-long v6, v6

    invoke-static {v6, v7}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, " "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v6, 0x7f0f0539

    goto :goto_2

    :goto_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1}, Lchat/ola/vn/entity/f;->a()Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    sget v0, Lchat/ola/vn/f;->H:I

    :goto_4
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_5

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    sget v0, Lchat/ola/vn/f;->z:I

    goto :goto_4

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    sget v0, Lchat/ola/vn/f;->z:I

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->r:Landroid/widget/TextView;

    const v0, 0x7f0f0536

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    :goto_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->t:I

    if-lez p1, :cond_9

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->s:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->t:I

    if-le p1, v5, :cond_8

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->s:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v6, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v6, v6, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v6, v6, Lchat/ola/vn/entity/f;->t:I

    int-to-long v6, v6

    invoke-static {v6, v7}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, " "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v6, 0x7f0f0487

    :goto_6
    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_7

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->s:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v6, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v6, v6, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v6, v6, Lchat/ola/vn/entity/f;->t:I

    int-to-long v6, v6

    invoke-static {v6, v7}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, " "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v6, 0x7f0f0486

    goto :goto_6

    :cond_9
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->s:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_7
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object p1, p1, v3

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object p1, p1, v5

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->h:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object p1, p1, v4

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->k()S

    move-result p1

    if-ne p1, v1, :cond_b

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->t:I

    if-nez p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->s:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c;->s:Landroid/widget/TextView;

    const v0, 0x7f0f0436

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    :cond_a
    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/c;->d()V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/c;->e()V

    :cond_b
    invoke-direct {p0}, Lchat/ola/vn/entry/b/a/c;->g()V

    return-void

    :cond_c
    invoke-virtual {p1}, Lchat/ola/vn/entry/b/ab;->g()V

    :cond_d
    return-void
.end method

.method public a(B)Z
    .locals 1

    const/4 v0, 0x1

    if-ne v0, p1, :cond_0

    return v0

    :cond_0
    const/4 p1, 0x0

    return p1
.end method

.method b(Lchat/ola/vn/entry/b/ab;)V
    .locals 0

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/ab;->g()V

    return-void
.end method
