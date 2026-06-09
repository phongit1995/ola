.class public Lchat/ola/vn/entry/b/ac;
.super Lchat/ola/vn/entry/b/j;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field private static k:Lchat/ola/vn/entity/z; = null

.field private static l:Ljava/lang/String; = null

.field private static m:Z = true


# instance fields
.field private A:Landroid/widget/TextView;

.field private B:Landroid/widget/TextView;

.field private C:Landroid/view/View;

.field private D:Landroid/widget/TextView;

.field protected i:Landroid/view/View;

.field protected j:Landroid/view/View;

.field private n:Lchat/ola/vn/view/OlaCachedImageView;

.field private o:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private p:[Lchat/ola/vn/view/OlaCachedImageView;

.field private q:Landroid/widget/TextView;

.field private r:Landroid/widget/TextView;

.field private s:Landroid/view/View;

.field private t:Landroid/view/View;

.field private u:Landroid/widget/TextView;

.field private v:Lchat/ola/vn/view/OlaCachedImageView;

.field private w:Landroid/widget/TextView;

.field private x:Landroid/widget/TextView;

.field private y:Landroid/view/View;

.field private z:Landroid/widget/Button;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/entry/b/j;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entity/z;)Lchat/ola/vn/entity/z;
    .locals 0

    sput-object p0, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    return-object p0
.end method

.method static synthetic e()Lchat/ola/vn/entity/z;
    .locals 1

    sget-object v0, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    return-object v0
.end method

.method private f()V
    .locals 3

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/entry/b/ac;->l:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    sput-object v0, Lchat/ola/vn/entry/b/ac;->l:Ljava/lang/String;

    sget-object v0, Lchat/ola/vn/entry/b/ac;->l:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/i;->e(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v2, Lchat/ola/vn/entry/b/ac$1;

    invoke-direct {v2, p0}, Lchat/ola/vn/entry/b/ac$1;-><init>(Lchat/ola/vn/entry/b/ac;)V

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/l;)V

    return-void

    :cond_0
    sget-object v0, Lchat/ola/vn/entry/b/ac;->l:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/i;->f(Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v2, Lchat/ola/vn/entry/b/ac$2;

    invoke-direct {v2, p0}, Lchat/ola/vn/entry/b/ac$2;-><init>(Lchat/ola/vn/entry/b/ac;)V

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/network/a/a/aj$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method


# virtual methods
.method public a()V
    .locals 11
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/entry/b/ac;->f()V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/ac;->n:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v2, v2

    const/16 v3, 0x8

    if-ge v1, v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v2, v2, v1

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->s:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->q:Landroid/widget/TextView;

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->D:Landroid/widget/TextView;

    sget-object v2, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v2, v2, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->y:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->C:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-short v1, v1, Lchat/ola/vn/entity/ag;->u:S

    if-nez v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->y:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->y:Landroid/view/View;

    const-string v2, "0"

    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->z:Landroid/widget/Button;

    const v2, 0x7f0f0444

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setText(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->A:Landroid/widget/TextView;

    const v2, 0x7f0f0329

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->B:Landroid/widget/TextView;

    const v2, 0x7f0f032b

    :goto_1
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(I)V

    goto :goto_2

    :cond_1
    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget v1, v1, Lchat/ola/vn/entity/ag;->q:I

    if-lez v1, :cond_2

    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget v1, v1, Lchat/ola/vn/entity/ag;->q:I

    const/4 v2, 0x3

    if-ge v1, v2, :cond_2

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->y:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->y:Landroid/view/View;

    const-string v2, "1"

    invoke-virtual {v1, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->z:Landroid/widget/Button;

    const v2, 0x7f0f04ea

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setText(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->A:Landroid/widget/TextView;

    const v2, 0x7f0f0246

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->B:Landroid/widget/TextView;

    const v2, 0x7f0f0247

    goto :goto_1

    :cond_2
    sget-object v1, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v1, v1, Lchat/ola/vn/entity/ag;->x:Z

    if-nez v1, :cond_3

    sget-boolean v1, Lchat/ola/vn/entry/b/ac;->m:Z

    if-eqz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->C:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_3
    :goto_2
    :try_start_3
    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    goto :goto_3

    :cond_4
    const/4 v1, 0x0

    :goto_3
    const/4 v2, 0x1

    if-lez v1, :cond_f

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->C:Landroid/view/View;

    invoke-virtual {v4, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->i:Landroid/view/View;

    invoke-virtual {v4, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->j:Landroid/view/View;

    invoke-virtual {v4, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->t:Landroid/view/View;

    invoke-virtual {v4, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->r:Landroid/widget/TextView;

    const v5, 0x7f0f063d

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(I)V

    const/4 v4, 0x5

    if-le v1, v4, :cond_6

    iget-object v3, p0, Lchat/ola/vn/entry/b/ac;->s:Landroid/view/View;

    if-eqz v3, :cond_5

    iget-object v3, p0, Lchat/ola/vn/entry/b/ac;->s:Landroid/view/View;

    invoke-virtual {v3, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_5
    iget-object v3, p0, Lchat/ola/vn/entry/b/ac;->q:Landroid/widget/TextView;

    invoke-virtual {v3, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v3, p0, Lchat/ola/vn/entry/b/ac;->q:Landroid/widget/TextView;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "+"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v5, v1, -0x5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4

    :cond_6
    if-ne v1, v4, :cond_7

    iget-object v3, p0, Lchat/ola/vn/entry/b/ac;->s:Landroid/view/View;

    if-eqz v3, :cond_8

    iget-object v3, p0, Lchat/ola/vn/entry/b/ac;->s:Landroid/view/View;

    invoke-virtual {v3, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_4

    :cond_7
    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->q:Landroid/widget/TextView;

    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_8
    :goto_4
    const/4 v3, 0x0

    :goto_5
    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    array-length v4, v4

    if-ge v3, v4, :cond_1c

    if-ge v3, v1, :cond_1c

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v4, v4, v3

    invoke-virtual {v4, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    invoke-interface {v4, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    move-object v6, v4

    check-cast v6, Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v5

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v4, v3

    const/4 v8, 0x0

    iget v9, p0, Lchat/ola/vn/entry/b/ac;->g:I

    iget v10, p0, Lchat/ola/vn/entry/b/ac;->g:I

    invoke-virtual/range {v5 .. v10}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;II)V

    const/4 v4, 0x2

    const-wide/high16 v5, 0x3ff0000000000000L    # 1.0

    packed-switch v1, :pswitch_data_0

    if-nez v3, :cond_c

    iget-object v7, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    goto :goto_6

    :pswitch_0
    if-nez v3, :cond_9

    iget-object v7, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v7, v0

    check-cast v7, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v7, v5, v6}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_9
    if-ne v3, v2, :cond_a

    iget-object v7, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v7, v2

    check-cast v7, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v7, v5, v6}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_a
    if-ne v3, v4, :cond_e

    iget-object v5, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v4, v5, v4

    check-cast v4, Lchat/ola/vn/view/OlaRatioImageView;

    const-wide v5, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    invoke-virtual {v4, v5, v6}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    goto :goto_7

    :pswitch_1
    const-wide/high16 v4, 0x3fe2000000000000L    # 0.5625

    if-nez v3, :cond_b

    iget-object v6, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v6, v6, v0

    check-cast v6, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v6, v4, v5}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_b
    if-ne v3, v2, :cond_e

    iget-object v6, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v6, v6, v2

    check-cast v6, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v6, v4, v5}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    goto :goto_7

    :goto_6
    aget-object v7, v7, v0

    check-cast v7, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v7, v5, v6}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_c
    if-ne v3, v2, :cond_d

    iget-object v7, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v7, v7, v2

    check-cast v7, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v7, v5, v6}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_d
    if-ne v3, v4, :cond_e

    iget-object v7, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    aget-object v4, v7, v4

    check-cast v4, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v4, v5, v6}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    :cond_e
    :goto_7
    :pswitch_2
    add-int/lit8 v3, v3, 0x1

    goto/16 :goto_5

    :cond_f
    sget-object v1, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    if-eqz v1, :cond_13

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->u:Landroid/widget/TextView;

    const v4, 0x7f0f064d

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->j:Landroid/view/View;

    invoke-virtual {v1, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->t:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->w:Landroid/widget/TextView;

    sget-object v4, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    iget-object v4, v4, Lchat/ola/vn/entity/z;->c:Ljava/lang/String;

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget-object v1, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    iget-object v1, v1, Lchat/ola/vn/entity/z;->e:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_10

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->x:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->x:Landroid/widget/TextView;

    sget-object v4, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    iget-object v4, v4, Lchat/ola/vn/entity/z;->e:Ljava/lang/String;

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_8

    :cond_10
    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->x:Landroid/widget/TextView;

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_8
    sget-object v1, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    iget-object v1, v1, Lchat/ola/vn/entity/z;->f:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_12

    iget-object v3, p0, Lchat/ola/vn/entry/b/ac;->v:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v3, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string v3, "http"

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_11

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/entry/b/ac;->v:Lchat/ola/vn/view/OlaCachedImageView;

    :goto_9
    invoke-virtual {v0, v1, v3, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V

    return-void

    :cond_11
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/entry/b/ac;->v:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v3, 0xf0

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    return-void

    :cond_12
    iget-object v0, p0, Lchat/ola/vn/entry/b/ac;->v:Lchat/ola/vn/view/OlaCachedImageView;

    :goto_a
    invoke-virtual {v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_13
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->f()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v1

    if-eqz v1, :cond_1b

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->u:Landroid/widget/TextView;

    const v4, 0x7f0f064b

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(I)V

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/n/c;->f()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v1

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->j:Landroid/view/View;

    invoke-virtual {v4, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->t:Landroid/view/View;

    invoke-virtual {v4, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->w:Landroid/widget/TextView;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->c()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->x:Landroid/widget/TextView;

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->i()I

    move-result v4

    const/16 v5, 0x64

    if-le v4, v5, :cond_14

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->x:Landroid/widget/TextView;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const v6, 0x7f0f0471

    invoke-static {v6}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, ": "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->i()I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    :goto_b
    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_c

    :cond_14
    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->d()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_15

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->x:Landroid/widget/TextView;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->d()Ljava/lang/String;

    move-result-object v5

    goto :goto_b

    :cond_15
    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->e()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_16

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->x:Landroid/widget/TextView;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->e()Ljava/lang/String;

    move-result-object v5

    goto :goto_b

    :cond_16
    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->h()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_17

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->x:Landroid/widget/TextView;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->h()Ljava/lang/String;

    move-result-object v5

    goto :goto_b

    :cond_17
    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->x:Landroid/widget/TextView;

    invoke-virtual {v4, v3}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_c
    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->f()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1a

    iget-object v4, p0, Lchat/ola/vn/entry/b/ac;->v:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v4, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string v4, "http"

    invoke-virtual {v0, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_18

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/entry/b/ac;->v:Lchat/ola/vn/view/OlaCachedImageView;

    goto/16 :goto_9

    :cond_18
    invoke-static {v1}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v0

    if-ne v0, v2, :cond_19

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/entry/b/ac;->v:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->b()Landroid/content/res/Resources;

    move-result-object v3

    const v4, 0x7f070133

    invoke-virtual {v3, v4}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v3

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    return-void

    :cond_19
    iget-object v0, p0, Lchat/ola/vn/entry/b/ac;->v:Lchat/ola/vn/view/OlaCachedImageView;

    goto/16 :goto_a

    :cond_1a
    iget-object v0, p0, Lchat/ola/vn/entry/b/ac;->v:Lchat/ola/vn/view/OlaCachedImageView;

    goto/16 :goto_a

    :cond_1b
    iget-object v0, p0, Lchat/ola/vn/entry/b/ac;->r:Landroid/widget/TextView;

    const v1, 0x7f0f00d7

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ac;->i:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ac;->j:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/ac;->t:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    return-void

    :catch_2
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1c
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public a(Landroid/view/View;)V
    .locals 7

    invoke-super {p0, p1}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View;)V

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/view/View;->setClickable(Z)V

    const v1, 0x7f0903a8

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f090144

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f09017a

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0903ca

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->C:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->C:Landroid/view/View;

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0903c2

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->D:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->D:Landroid/widget/TextView;

    invoke-virtual {v1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0905df

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f09017b

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f090605

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->y:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->y:Landroid/view/View;

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f090604

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->z:Landroid/widget/Button;

    const v1, 0x7f090606

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->A:Landroid/widget/TextView;

    const v1, 0x7f090607

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->B:Landroid/widget/TextView;

    const v1, 0x7f09017d

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->i:Landroid/view/View;

    const v1, 0x7f090080

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->j:Landroid/view/View;

    const v1, 0x7f0904d2

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->r:Landroid/widget/TextView;

    const v1, 0x7f09028e

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->n:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->n:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const/4 v1, 0x5

    new-array v1, v1, [Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    const v2, 0x7f090348

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v3, 0x0

    aput-object v2, v1, v3

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    const v2, 0x7f090349

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    aput-object v2, v1, v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    const v2, 0x7f09034a

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v4, 0x2

    aput-object v2, v1, v4

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    const v2, 0x7f09034b

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v4, 0x3

    aput-object v2, v1, v4

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->p:[Lchat/ola/vn/view/OlaCachedImageView;

    const v2, 0x7f09034c

    invoke-virtual {p1, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v4, 0x4

    aput-object v2, v1, v4

    const v1, 0x7f090361

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->q:Landroid/widget/TextView;

    const v1, 0x7f0904c4

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->s:Landroid/view/View;

    const v1, 0x7f0904ad

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->t:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->t:Landroid/view/View;

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0902ba

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->u:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->u:Landroid/widget/TextView;

    const v2, 0x7f0f064b

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(I)V

    const v1, 0x7f0902b7

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->v:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f0902b9

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->w:Landroid/widget/TextView;

    const v1, 0x7f0902b8

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/entry/b/ac;->x:Landroid/widget/TextView;

    const v1, 0x7f0902b6

    invoke-virtual {p1, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/e;->q()Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_3

    new-instance p1, Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {p1, v1}, Ljava/util/ArrayList;-><init>(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v2, 0x0

    const/4 v4, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    :try_start_1
    iget-object v5, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    invoke-interface {v5, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-static {v5}, Lcom/mg/ola/common/d/c;->a(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-static {v5}, Lchat/ola/vn/d;->f(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_1

    invoke-interface {p1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_0
    const/4 v4, 0x1

    :cond_1
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    iput-object p1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_2

    :catch_0
    :cond_3
    const/4 v4, 0x0

    :catch_1
    :goto_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    if-lez p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->i:Landroid/view/View;

    invoke-virtual {p1, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->j:Landroid/view/View;

    invoke-virtual {p1, v3}, Landroid/view/View;->setVisibility(I)V

    :goto_3
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/e;->o()V

    return-void

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->i:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->j:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    if-eqz v4, :cond_5

    goto :goto_3

    :cond_5
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    const-string v0, "0"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_0
    const-string v0, "1"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->b(Landroid/content/Context;)V

    return-void

    :cond_1
    const-string v0, "2"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_b

    :sswitch_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->a(Landroid/content/Context;)V

    return-void

    :sswitch_2
    sget-object p1, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    if-eqz p1, :cond_4

    const-string p1, ""

    sget-object v0, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    iget-object v0, v0, Lchat/ola/vn/entity/z;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object p1, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    iget-object p1, p1, Lchat/ola/vn/entity/z;->c:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "\n"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :cond_2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object p1, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    iget-object p1, p1, Lchat/ola/vn/entity/z;->a:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "\n"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    iget-object v0, v0, Lchat/ola/vn/entity/z;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object p1, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    iget-object p1, p1, Lchat/ola/vn/entity/z;->e:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "\n"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :cond_3
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-static {v0, p1, v2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    sput-object v2, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    const-string v0, ""

    invoke-static {p1, v0}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_4
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->f()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Lchat/ola/vn/entity/OlaVenueEntity;)V

    return-void

    :sswitch_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->t:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    sget-object p1, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;

    if-eqz p1, :cond_5

    sput-object v2, Lchat/ola/vn/entry/b/ac;->k:Lchat/ola/vn/entity/z;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    const-string v0, ""

    invoke-static {p1, v0}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :cond_5
    :try_start_2
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/n/c;->f()Lchat/ola/vn/entity/OlaVenueEntity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/n/c;->a(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p1

    invoke-virtual {p1, v2}, Lchat/ola/vn/n/c;->a(Lchat/ola/vn/entity/OlaVenueEntity;)V

    :catch_0
    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/entry/b/ac;->a()V

    return-void

    :sswitch_4
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/me/c;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;)V

    return-void

    :sswitch_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->C:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    const/4 p1, 0x0

    sput-boolean p1, Lchat/ola/vn/entry/b/ac;->m:Z

    return-void

    :sswitch_6
    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->i:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->j:Landroid/view/View;

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->clear()V

    iput-object v2, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    goto :goto_0

    :sswitch_7
    const/4 p1, 0x1

    sput-boolean p1, Lchat/ola/vn/me/OlaMeComposerActivity;->e:Z

    :sswitch_8
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p1

    const-string v0, "my diary"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_6

    const/16 p1, 0xa

    sput-short p1, Lchat/ola/vn/c/x;->j:S

    goto :goto_1

    :cond_6
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p1

    const-string v0, "mariage diary"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_7

    const/16 p1, 0xb

    sput-short p1, Lchat/ola/vn/c/x;->j:S

    goto :goto_1

    :cond_7
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/r/a/e;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_8

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object p1

    const-string v0, "#"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "@"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    goto :goto_2

    :cond_8
    :goto_1
    move-object p1, v2

    :cond_9
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    if-eqz v0, :cond_a

    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    goto :goto_3

    :cond_a
    move-object v0, v2

    :goto_3
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    invoke-static {v1, p1, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->c(Landroid/content/Context;Ljava/lang/String;Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    if-eqz p1, :cond_b

    iget-object p1, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->clear()V

    iput-object v2, p0, Lchat/ola/vn/entry/b/ac;->o:Ljava/util/List;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_b
    return-void

    :sswitch_data_0
    .sparse-switch
        0x7f090144 -> :sswitch_7
        0x7f09017a -> :sswitch_6
        0x7f09017b -> :sswitch_5
        0x7f09028e -> :sswitch_4
        0x7f0902b6 -> :sswitch_3
        0x7f0903a8 -> :sswitch_8
        0x7f0903c2 -> :sswitch_1
        0x7f0903ca -> :sswitch_1
        0x7f0904ad -> :sswitch_2
        0x7f0905df -> :sswitch_1
        0x7f090605 -> :sswitch_0
    .end sparse-switch
.end method
