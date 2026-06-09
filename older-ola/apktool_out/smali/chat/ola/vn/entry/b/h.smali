.class public Lchat/ola/vn/entry/b/h;
.super Ljava/lang/Object;


# instance fields
.field public a:Landroid/view/View;

.field public b:Landroid/view/View;

.field private c:I

.field private d:I

.field private e:Landroid/view/View;

.field private f:Lchat/ola/vn/view/OlaRatioImageView;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/widget/TextView;

.field private j:Landroid/widget/TextView;

.field private k:Lchat/ola/vn/entity/e;

.field private l:Landroid/view/View$OnClickListener;

.field private m:Landroid/view/View$OnLongClickListener;

.field private n:Landroid/widget/ImageView;

.field private o:Landroid/widget/ImageView;

.field private p:Landroid/view/View;

.field private q:Landroid/view/View;

.field private r:Landroid/widget/ImageView;

.field private s:Landroid/widget/TextView;

.field private t:Landroid/view/View;

.field private u:Landroid/widget/TextView;

.field private v:Landroid/widget/TextView;

.field private w:Landroid/widget/ImageView;

.field private x:Landroid/widget/TextView;

.field private y:Landroid/view/View;

.field private z:Landroid/view/View;


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Landroid/view/View;D)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const v1, 0x7f0902e9

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/h;->b:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const v1, 0x7f0902b0

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/h;->f:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->f:Lchat/ola/vn/view/OlaRatioImageView;

    sget-object v1, Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;->a:Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setBaseOrientation(Lchat/ola/vn/view/OlaRatioImageView$BASE_SIDE;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->f:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, p2, p3}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0902e8

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->a:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0902b1

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0902af

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->n:Landroid/widget/ImageView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0905af

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->g:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0905b0

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->h:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0905ac

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->i:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0905ae

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->j:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0900e7

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->q:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f09028b

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->r:Landroid/widget/ImageView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f09053c

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->s:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0900e6

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->t:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f09053b

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->u:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f09032a

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->y:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f09053d

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->x:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0900e4

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->w:Landroid/widget/ImageView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0905ad

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->v:Landroid/widget/TextView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0902f7

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->z:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    const p3, 0x7f0900e8

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p0, Lchat/ola/vn/entry/b/h;->p:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method

.method public static a()I
    .locals 1

    const/4 v0, 0x4

    return v0
.end method

.method public static a(I)I
    .locals 1

    const/4 v0, -0x6

    if-eq p0, v0, :cond_1

    const/4 v0, -0x2

    if-eq p0, v0, :cond_1

    if-eqz p0, :cond_1

    const/4 v0, 0x2

    if-eq p0, v0, :cond_0

    const/4 v0, 0x0

    packed-switch p0, :pswitch_data_0

    return v0

    :pswitch_0
    const/4 p0, 0x1

    return p0

    :cond_0
    :pswitch_1
    return v0

    :cond_1
    const/4 p0, 0x3

    return p0

    nop

    :pswitch_data_0
    .packed-switch 0x64
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public static a(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;I)Landroid/view/View;
    .locals 4

    const/4 v0, -0x6

    const/4 v1, 0x0

    if-eq p2, v0, :cond_1

    const/4 v0, -0x2

    if-eq p2, v0, :cond_1

    if-eqz p2, :cond_1

    const/4 v0, 0x2

    if-eq p2, v0, :cond_0

    const-wide v2, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    const v0, 0x7f0b00e1

    packed-switch p2, :pswitch_data_0

    invoke-virtual {p0, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p0

    new-instance p2, Lchat/ola/vn/entry/b/h;

    invoke-direct {p2, p0, v2, v3}, Lchat/ola/vn/entry/b/h;-><init>(Landroid/view/View;D)V

    goto :goto_0

    :pswitch_0
    invoke-virtual {p0, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p0

    new-instance p2, Lchat/ola/vn/entry/b/h;

    invoke-direct {p2, p0, v2, v3}, Lchat/ola/vn/entry/b/h;-><init>(Landroid/view/View;D)V

    goto :goto_0

    :cond_0
    const p2, 0x7f0b00d5

    invoke-virtual {p0, p2, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p0

    new-instance p2, Lchat/ola/vn/entry/b/h;

    const-wide/high16 v0, 0x3ff0000000000000L    # 1.0

    invoke-direct {p2, p0, v0, v1}, Lchat/ola/vn/entry/b/h;-><init>(Landroid/view/View;D)V

    goto :goto_0

    :cond_1
    const p2, 0x7f0b00e0

    invoke-virtual {p0, p2, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p0

    new-instance p2, Lchat/ola/vn/entry/b/h;

    invoke-direct {p2}, Lchat/ola/vn/entry/b/h;-><init>()V

    iput-object p0, p2, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    invoke-virtual {p0, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    :goto_0
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f07010e

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p2, Lchat/ola/vn/entry/b/h;->c:I

    iput p1, p2, Lchat/ola/vn/entry/b/h;->d:I

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x64
        :pswitch_0
        :pswitch_0
        :pswitch_0
    .end packed-switch
.end method

.method public static a(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Landroid/view/View;
    .locals 2

    const p2, 0x7f0b00da

    const/4 v0, 0x0

    invoke-virtual {p0, p2, p1, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p0

    new-instance p1, Lchat/ola/vn/entry/b/h;

    const-wide v0, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    invoke-direct {p1, p0, v0, v1}, Lchat/ola/vn/entry/b/h;-><init>(Landroid/view/View;D)V

    sget p2, Lchat/ola/vn/e;->c:I

    sget v0, Lchat/ola/vn/e;->d:I

    invoke-static {p2, v0}, Ljava/lang/Math;->min(II)I

    move-result p2

    iput p2, p1, Lchat/ola/vn/entry/b/h;->c:I

    sget p2, Lchat/ola/vn/e;->c:I

    sget v0, Lchat/ola/vn/e;->d:I

    invoke-static {p2, v0}, Ljava/lang/Math;->min(II)I

    move-result p2

    iput p2, p1, Lchat/ola/vn/entry/b/h;->d:I

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/h;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/h;->y:Landroid/view/View;

    return-object p0
.end method

.method private a(Lchat/ola/vn/entity/e;Landroid/view/ViewGroup;)V
    .locals 10

    const v0, 0x7f0902f9

    :try_start_0
    invoke-virtual {p2, v0}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->m()Ljava/util/List;

    move-result-object v1

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->l()Lchat/ola/vn/entity/e;

    if-eqz v1, :cond_6

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v2

    :goto_0
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    invoke-virtual {p2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v4

    const/4 v5, 0x0

    if-le v3, v4, :cond_0

    const v3, 0x7f0b00df

    invoke-virtual {v2, v3, p2, v5}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v3

    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v6, -0x1

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v4, v5, v6, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {p2, v3, v4}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_0

    :cond_0
    :goto_1
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    invoke-virtual {p2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    const/4 v4, 0x1

    if-ge v2, v3, :cond_1

    invoke-virtual {p2}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    sub-int/2addr v2, v4

    invoke-virtual {p2, v2}, Landroid/view/ViewGroup;->removeViewAt(I)V

    goto :goto_1

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->l()Lchat/ola/vn/entity/e;

    move-result-object v2

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    move-object v6, v2

    const/4 v2, 0x0

    :goto_2
    if-ge v2, v3, :cond_6

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lchat/ola/vn/entity/e;

    invoke-virtual {p2, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/TextView;

    invoke-virtual {v7}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {v8, v7}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    new-instance v9, Lchat/ola/vn/entry/b/h$3;

    invoke-direct {v9, p0, p1, v7, v0}, Lchat/ola/vn/entry/b/h$3;-><init>(Lchat/ola/vn/entry/b/h;Lchat/ola/vn/entity/e;Lchat/ola/vn/entity/e;Landroid/view/View;)V

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    if-nez v2, :cond_2

    const v9, 0x7f080131

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setBackgroundResource(I)V

    goto :goto_3

    :cond_2
    add-int/lit8 v9, v3, -0x1

    if-ne v2, v9, :cond_3

    const v9, 0x7f08013d

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setBackgroundResource(I)V

    goto :goto_3

    :cond_3
    const v9, 0x7f080134

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setBackgroundResource(I)V

    :goto_3
    if-nez v6, :cond_4

    invoke-virtual {p1, v7}, Lchat/ola/vn/entity/e;->c(Lchat/ola/vn/entity/e;)V

    invoke-virtual {v8, v4}, Landroid/widget/TextView;->setSelected(Z)V

    move-object v6, v7

    goto :goto_4

    :cond_4
    if-ne v6, v7, :cond_5

    invoke-virtual {v8, v4}, Landroid/widget/TextView;->setSelected(Z)V

    goto :goto_4

    :cond_5
    invoke-virtual {v8, v5}, Landroid/widget/TextView;->setSelected(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :goto_4
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :catch_0
    :cond_6
    return-void
.end method

.method private a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;Z)V
    .locals 1

    if-nez p2, :cond_0

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    return-void

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0, p2, p1, p3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V

    return-void
.end method

.method private b(I)I
    .locals 3

    const v0, 0x7f080689

    const/16 v1, 0x32

    if-gt p1, v1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->a()Z

    move-result p1

    if-eqz p1, :cond_0

    const p1, 0x7f080702

    return p1

    :cond_0
    return v0

    :cond_1
    const/16 v2, 0x64

    if-le p1, v1, :cond_2

    if-gt p1, v2, :cond_2

    const p1, 0x7f080669

    return p1

    :cond_2
    const/16 v1, 0xc8

    if-le p1, v2, :cond_3

    if-gt p1, v1, :cond_3

    const p1, 0x7f08066a

    return p1

    :cond_3
    if-le p1, v1, :cond_4

    const p1, 0x7f08066b

    return p1

    :cond_4
    return v0
.end method

.method public static b(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Landroid/view/View;
    .locals 2

    const p2, 0x7f0b00d9

    const/4 v0, 0x0

    invoke-virtual {p0, p2, p1, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p0

    new-instance p1, Lchat/ola/vn/entry/b/h;

    const-wide v0, 0x3ffc71c71c71c71cL    # 1.7777777777777777

    invoke-direct {p1, p0, v0, v1}, Lchat/ola/vn/entry/b/h;-><init>(Landroid/view/View;D)V

    sget p2, Lchat/ola/vn/e;->c:I

    sget v0, Lchat/ola/vn/e;->d:I

    invoke-static {p2, v0}, Ljava/lang/Math;->min(II)I

    move-result p2

    iput p2, p1, Lchat/ola/vn/entry/b/h;->c:I

    sget p2, Lchat/ola/vn/e;->c:I

    sget v0, Lchat/ola/vn/e;->d:I

    invoke-static {p2, v0}, Ljava/lang/Math;->min(II)I

    move-result p2

    iput p2, p1, Lchat/ola/vn/entry/b/h;->d:I

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/entry/b/h;)Landroid/widget/ImageView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/h;->w:Landroid/widget/ImageView;

    return-object p0
.end method

.method private b()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->Q()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->g()Ljava/util/List;

    move-result-object v1

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    const/16 v3, 0x8

    if-eqz v2, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->w:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->w:Landroid/widget/ImageView;

    invoke-virtual {v0, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->y:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->v:Landroid/widget/TextView;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->v:Landroid/widget/TextView;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->v:Landroid/widget/TextView;

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->w:Landroid/widget/ImageView;

    new-instance v3, Lchat/ola/vn/entry/b/h$1;

    invoke-direct {v3, p0, v0, v1}, Lchat/ola/vn/entry/b/h$1;-><init>(Lchat/ola/vn/entry/b/h;Ljava/lang/String;Ljava/util/List;)V

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method private c()V
    .locals 10

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->x:Landroid/widget/TextView;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->g()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    new-instance v1, Landroid/text/SpannableStringBuilder;

    const-string v2, " "

    invoke-direct {v1, v2}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    const/4 v3, 0x0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v2, :cond_0

    invoke-interface {v0, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/entity/e;

    invoke-virtual {v5}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v1, v6}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    const-string v7, " "

    invoke-virtual {v1, v7}, Landroid/text/SpannableStringBuilder;->append(Ljava/lang/CharSequence;)Landroid/text/SpannableStringBuilder;

    new-instance v7, Lchat/ola/vn/entry/b/h$2;

    iget-object v8, p0, Lchat/ola/vn/entry/b/h;->x:Landroid/widget/TextView;

    invoke-virtual {v8}, Landroid/widget/TextView;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    const v9, 0x7f06004d

    invoke-virtual {v8, v9}, Landroid/content/res/Resources;->getColor(I)I

    move-result v8

    const/4 v9, 0x1

    invoke-direct {v7, p0, v8, v9, v5}, Lchat/ola/vn/entry/b/h$2;-><init>(Lchat/ola/vn/entry/b/h;IZLchat/ola/vn/entity/e;)V

    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v5

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v6

    sub-int/2addr v5, v6

    sub-int/2addr v5, v9

    invoke-virtual {v1}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v6

    sub-int/2addr v6, v9

    const/16 v8, 0x21

    invoke-virtual {v1, v7, v5, v6, v8}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->x:Landroid/widget/TextView;

    invoke-static {}, Landroid/text/method/LinkMovementMethod;->getInstance()Landroid/text/method/MovementMethod;

    move-result-object v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setMovementMethod(Landroid/text/method/MovementMethod;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->x:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->x:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->x:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method

.method static synthetic c(Lchat/ola/vn/entry/b/h;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/h;->b()V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/entry/b/h;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/h;->x:Landroid/widget/TextView;

    return-object p0
.end method

.method private d()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->r:Landroid/widget/ImageView;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->s:Landroid/widget/TextView;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->q:Landroid/view/View;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->q:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->q:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/entry/b/h;->l:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->b()I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/h;->r:Landroid/widget/ImageView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/h;->r:Landroid/widget/ImageView;

    invoke-direct {p0, v0}, Lchat/ola/vn/entry/b/h;->b(I)I

    move-result v3

    invoke-virtual {v1, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    if-lez v0, :cond_2

    iget-object v1, p0, Lchat/ola/vn/entry/b/h;->s:Landroid/widget/TextView;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/h;->s:Landroid/widget/TextView;

    int-to-long v3, v0

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->a()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->q:Landroid/view/View;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->s:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->g:I

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->q:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->s:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->z:I

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->q:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->s:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_3
    return-void
.end method

.method static synthetic e(Lchat/ola/vn/entry/b/h;)Landroid/view/View$OnClickListener;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/h;->l:Landroid/view/View$OnClickListener;

    return-object p0
.end method


# virtual methods
.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/h;->l:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/h;->m:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public a(Lchat/ola/vn/entity/e;)V
    .locals 9

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->z:Landroid/view/View;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->z:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->E()I

    move-result v0

    const/4 v2, -0x6

    if-eq v0, v2, :cond_14

    const/4 v2, -0x2

    if-eq v0, v2, :cond_14

    if-eqz v0, :cond_14

    const/16 v2, 0x66

    const/4 v3, 0x4

    if-eq v0, v2, :cond_1

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->z:Landroid/view/View;

    if-eqz v2, :cond_2

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->z:Landroid/view/View;

    invoke-virtual {v2, v3}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    :goto_0
    iput-object p1, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v2}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object v2

    iget-object v4, p0, Lchat/ola/vn/entry/b/h;->g:Landroid/widget/TextView;

    invoke-virtual {v4, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->y:Landroid/view/View;

    const/16 v4, 0x8

    if-eqz v2, :cond_3

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->y:Landroid/view/View;

    invoke-virtual {v2, v4}, Landroid/view/View;->setVisibility(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->w:Landroid/widget/ImageView;

    const v5, 0x7f0806ba

    invoke-virtual {v2, v5}, Landroid/widget/ImageView;->setImageResource(I)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/h;->b()V

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/entry/b/h;->c()V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->h:Landroid/widget/TextView;

    if-eqz v2, :cond_4

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v2}, Lchat/ola/vn/entity/e;->D()I

    move-result v2

    int-to-long v5, v2

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->h:Landroid/widget/TextView;

    invoke-static {v5, v6}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v2, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_4
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->i:Landroid/widget/TextView;

    if-eqz v2, :cond_5

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v2}, Lchat/ola/vn/entity/e;->F()J

    move-result-wide v5

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/b;->c()[Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v7

    invoke-virtual {v7}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object v7

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v8

    invoke-virtual {v8}, Lchat/ola/vn/b;->b()[Ljava/lang/String;

    move-result-object v8

    invoke-static {v5, v6, v2, v7, v8}, Lcom/mg/ola/common/d/i;->a(J[Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget-object v5, p0, Lchat/ola/vn/entry/b/h;->i:Landroid/widget/TextView;

    invoke-virtual {v5, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_5
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->j:Landroid/widget/TextView;

    const/16 v5, 0x65

    const/4 v6, -0x4

    if-eqz v2, :cond_9

    if-eq v0, v6, :cond_8

    if-ne v0, v5, :cond_6

    goto :goto_1

    :cond_6
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v2}, Lchat/ola/vn/entity/e;->C()I

    move-result v2

    if-nez v2, :cond_7

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->j:Landroid/widget/TextView;

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    :cond_7
    int-to-long v2, v2

    const-string v7, ":"

    const-string v8, ":"

    invoke-static {v2, v3, v7, v8}, Lcom/mg/ola/common/d/i;->a(JLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/entry/b/h;->j:Landroid/widget/TextView;

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->j:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    :cond_8
    :goto_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->j:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v7, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v7}, Lchat/ola/vn/entity/e;->i()I

    move-result v7

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v7, " "

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->j:Landroid/widget/TextView;

    iget-object v3, p0, Lchat/ola/vn/entry/b/h;->j:Landroid/widget/TextView;

    invoke-virtual {v3}, Landroid/widget/TextView;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const v7, 0x7f0f0464

    invoke-virtual {v3, v7}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->append(Ljava/lang/CharSequence;)V

    :cond_9
    :goto_2
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->u:Landroid/widget/TextView;

    if-eqz v2, :cond_b

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v2}, Lchat/ola/vn/entity/e;->c()I

    move-result v2

    if-nez v2, :cond_a

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->u:Landroid/widget/TextView;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_3

    :cond_a
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->u:Landroid/widget/TextView;

    iget-object v3, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v3}, Lchat/ola/vn/entity/e;->c()I

    move-result v3

    int-to-long v7, v3

    invoke-static {v7, v8}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->u:Landroid/widget/TextView;

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_b
    :goto_3
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->t:Landroid/view/View;

    if-eqz v2, :cond_c

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->t:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    invoke-virtual {v2, v3}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->t:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/entry/b/h;->l:Landroid/view/View$OnClickListener;

    invoke-virtual {v2, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_c
    invoke-direct {p0}, Lchat/ola/vn/entry/b/h;->d()V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->f:Lchat/ola/vn/view/OlaRatioImageView;

    if-eqz v2, :cond_e

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->k:Lchat/ola/vn/entity/e;

    iget v3, p0, Lchat/ola/vn/entry/b/h;->c:I

    iget v7, p0, Lchat/ola/vn/entry/b/h;->d:I

    invoke-virtual {v2, v3, v7}, Lchat/ola/vn/entity/e;->a(II)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/entry/b/h;->f:Lchat/ola/vn/view/OlaRatioImageView;

    iget v7, p0, Lchat/ola/vn/entry/b/h;->c:I

    sget v8, Lchat/ola/vn/e;->c:I

    if-eq v7, v8, :cond_d

    const/4 v7, 0x1

    goto :goto_4

    :cond_d
    const/4 v7, 0x0

    :goto_4
    invoke-direct {p0, v3, v2, v7}, Lchat/ola/vn/entry/b/h;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;Z)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->f:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v2, p1}, Lchat/ola/vn/view/OlaRatioImageView;->setTag(Ljava/lang/Object;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->f:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v3, p0, Lchat/ola/vn/entry/b/h;->l:Landroid/view/View$OnClickListener;

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaRatioImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->f:Lchat/ola/vn/view/OlaRatioImageView;

    iget-object v3, p0, Lchat/ola/vn/entry/b/h;->m:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaRatioImageView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    :cond_e
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->p:Landroid/view/View;

    if-eqz v2, :cond_f

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->p:Landroid/view/View;

    invoke-virtual {v2, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->p:Landroid/view/View;

    iget-object v3, p0, Lchat/ola/vn/entry/b/h;->l:Landroid/view/View$OnClickListener;

    invoke-virtual {v2, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->p:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_f
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->n:Landroid/widget/ImageView;

    if-eqz v2, :cond_10

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->G()S

    move-result v2

    const v3, 0x7f080761

    packed-switch v2, :pswitch_data_0

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->n:Landroid/widget/ImageView;

    goto :goto_6

    :pswitch_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->A()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result v2

    packed-switch v2, :pswitch_data_1

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->n:Landroid/widget/ImageView;

    goto :goto_6

    :pswitch_1
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->n:Landroid/widget/ImageView;

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->n:Landroid/widget/ImageView;

    :goto_5
    invoke-virtual {v2, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    goto :goto_7

    :goto_6
    invoke-virtual {v2, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    goto :goto_7

    :pswitch_2
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->n:Landroid/widget/ImageView;

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->n:Landroid/widget/ImageView;

    goto :goto_5

    :cond_10
    :goto_7
    iget-object v2, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    if-eqz v2, :cond_13

    if-eq v0, v5, :cond_12

    if-ne v0, v6, :cond_11

    goto :goto_a

    :cond_11
    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->G()S

    move-result v0

    const v2, 0x7f0806f6

    const v3, 0x7f0806f2

    packed-switch v0, :pswitch_data_2

    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    goto :goto_9

    :pswitch_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    const v0, 0x7f0806f1

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    :goto_8
    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void

    :pswitch_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    const v0, 0x7f0806ef

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    goto :goto_8

    :pswitch_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    invoke-virtual {p1, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    goto :goto_8

    :pswitch_6
    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->A()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result p1

    packed-switch p1, :pswitch_data_3

    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    goto :goto_9

    :pswitch_7
    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    const v0, 0x7f0806f4

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    goto :goto_8

    :pswitch_8
    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    goto :goto_8

    :pswitch_9
    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    invoke-virtual {p1, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    goto :goto_8

    :goto_9
    invoke-virtual {p1, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void

    :pswitch_a
    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    goto :goto_8

    :cond_12
    :goto_a
    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;

    const v0, 0x7f0806f3

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/h;->o:Landroid/widget/ImageView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_8

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_13
    return-void

    :cond_14
    iget-object v0, p0, Lchat/ola/vn/entry/b/h;->e:Landroid/view/View;

    check-cast v0, Landroid/view/ViewGroup;

    invoke-direct {p0, p1, v0}, Lchat/ola/vn/entry/b/h;->a(Lchat/ola/vn/entity/e;Landroid/view/ViewGroup;)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x2
        :pswitch_1
        :pswitch_1
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x1
        :pswitch_a
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
    .end packed-switch

    :pswitch_data_3
    .packed-switch 0x1
        :pswitch_9
        :pswitch_8
        :pswitch_7
    .end packed-switch
.end method
