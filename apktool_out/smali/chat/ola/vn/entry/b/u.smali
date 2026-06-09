.class public Lchat/ola/vn/entry/b/u;
.super Lchat/ola/vn/entry/b/f;


# instance fields
.field private t:Lchat/ola/vn/view/OlaCachedImageView;

.field private u:Landroid/widget/TextView;

.field private v:Landroid/view/View;

.field private w:Ljava/lang/String;

.field private final x:I

.field private y:Lchat/ola/vn/message/k;


# direct methods
.method public constructor <init>(Landroid/view/View;I)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/f;-><init>(Landroid/view/View;)V

    const/16 v0, 0x10

    iput v0, p0, Lchat/ola/vn/entry/b/u;->x:I

    iget-object v0, p0, Lchat/ola/vn/entry/b/u;->q:Landroid/view/ViewStub;

    invoke-virtual {v0, p2}, Landroid/view/ViewStub;->setLayoutResource(I)V

    iget-object p2, p0, Lchat/ola/vn/entry/b/u;->q:Landroid/view/ViewStub;

    invoke-virtual {p2}, Landroid/view/ViewStub;->inflate()Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/u;->q:Landroid/view/ViewStub;

    const/4 v0, 0x0

    invoke-virtual {p2, v0}, Landroid/view/ViewStub;->setVisibility(I)V

    const p2, 0x7f090354

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/u;->t:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/u;->t:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/u;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f090037

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/entry/b/u;->u:Landroid/widget/TextView;

    const p2, 0x7f09030e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/entry/b/u;->v:Landroid/view/View;

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/u;->i:Lcom/mg/ola/common/widget/OlaTextView;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Lcom/mg/ola/common/widget/OlaTextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/u;->d:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const p2, 0x7f07013c

    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/entry/b/u;->e:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/u;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/u;->g()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/entry/b/u;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/u;->w:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/entry/b/u;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/u;->v:Landroid/view/View;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/entry/b/u;)Lchat/ola/vn/view/OlaCachedImageView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/u;->t:Lchat/ola/vn/view/OlaCachedImageView;

    return-object p0
.end method

.method private g()V
    .locals 11

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/u;->t:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/u;->y:Lchat/ola/vn/message/k;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/u;->y:Lchat/ola/vn/message/k;

    invoke-virtual {v0}, Lchat/ola/vn/message/k;->a()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/u;->y:Lchat/ola/vn/message/k;

    invoke-virtual {v1}, Lchat/ola/vn/message/k;->C()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/u;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v2}, Lchat/ola/vn/view/OlaCachedImageView;->getWidth()I

    move-result v2

    iget-object v3, p0, Lchat/ola/vn/entry/b/u;->t:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v3}, Lchat/ola/vn/view/OlaCachedImageView;->getHeight()I

    move-result v3

    const/16 v4, 0x10

    invoke-static {v1, v0, v2, v3, v4}, Lchat/ola/vn/c/f;->a(Ljava/lang/String;Ljava/lang/String;III)Lchat/ola/vn/c/f;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/c/f;->e()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Lchat/ola/vn/entry/b/u;->w:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/entry/b/u;->y:Lchat/ola/vn/message/k;

    invoke-virtual {v3}, Lchat/ola/vn/message/k;->D()Ljava/util/List;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    iget-object v3, p0, Lchat/ola/vn/entry/b/u;->y:Lchat/ola/vn/message/k;

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v3, v5}, Lchat/ola/vn/message/k;->b(Ljava/util/List;)V

    iget-object v3, p0, Lchat/ola/vn/entry/b/u;->y:Lchat/ola/vn/message/k;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v5

    invoke-static {v0}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v6

    invoke-static {v1}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v8

    new-instance v10, Lchat/ola/vn/entry/b/u$1;

    invoke-direct {v10, p0, v3}, Lchat/ola/vn/entry/b/u$1;-><init>(Lchat/ola/vn/entry/b/u;Lchat/ola/vn/message/k;)V

    invoke-static/range {v5 .. v10}, Lchat/ola/vn/n/b;->a(Landroid/content/Context;DDLchat/ola/vn/n/b$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_2

    :cond_0
    :try_start_1
    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/location/Address;

    invoke-static {v0}, Lchat/ola/vn/n/b;->a(Landroid/location/Address;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    iget-object v1, p0, Lchat/ola/vn/entry/b/u;->y:Lchat/ola/vn/message/k;

    invoke-virtual {v1}, Lchat/ola/vn/message/k;->d()B

    move-result v1

    const/4 v3, 0x2

    if-ne v1, v3, :cond_1

    iget-object v1, p0, Lchat/ola/vn/entry/b/u;->u:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->D:I

    :goto_0
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_1

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/u;->u:Landroid/widget/TextView;

    sget v3, Lchat/ola/vn/f;->z:I

    goto :goto_0

    :goto_1
    iget-object v1, p0, Lchat/ola/vn/entry/b/u;->u:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/u;->u:Landroid/widget/TextView;

    invoke-virtual {v0, v4}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/u;->u:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_2
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/entry/b/u;->t:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/u;->w:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/entry/b/u;->v:Landroid/view/View;

    invoke-virtual {v0, v4}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/u;->t:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/u;->t:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f080711

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/u;->w:Ljava/lang/String;

    new-instance v3, Lchat/ola/vn/entry/b/u$2;

    invoke-direct {v3, p0, v2}, Lchat/ola/vn/entry/b/u$2;-><init>(Lchat/ola/vn/entry/b/u;Lchat/ola/vn/c/f;)V

    invoke-virtual {v0, v1, v3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/c/w;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_3
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
    .locals 0

    :try_start_0
    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/entry/b/f;->a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V

    check-cast p1, Lchat/ola/vn/message/k;

    iput-object p1, p0, Lchat/ola/vn/entry/b/u;->y:Lchat/ola/vn/message/k;

    invoke-direct {p0}, Lchat/ola/vn/entry/b/u;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
