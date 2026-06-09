.class public Lchat/ola/vn/cloud/a$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/cloud/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation


# instance fields
.field protected a:Landroid/view/View;

.field protected b:Landroid/view/View;

.field protected c:Lchat/ola/vn/view/OlaRatioImageView;

.field protected d:Landroid/widget/TextView;

.field protected e:Landroid/widget/TextView;

.field final synthetic f:Lchat/ola/vn/cloud/a;

.field private g:Lchat/ola/vn/entity/l;


# direct methods
.method protected constructor <init>(Lchat/ola/vn/cloud/a;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/a$a;->f:Lchat/ola/vn/cloud/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f090182

    :try_start_0
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/cloud/a$a;->a:Landroid/view/View;

    const p1, 0x7f09017e

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/cloud/a$a;->b:Landroid/view/View;

    const p1, 0x7f090180

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object p1, p0, Lchat/ola/vn/cloud/a$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    const p1, 0x7f09017f

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/cloud/a$a;->d:Landroid/widget/TextView;

    const p1, 0x7f090181

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/cloud/a$a;->e:Landroid/widget/TextView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/cloud/a$a;)Lchat/ola/vn/entity/l;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    return-object p0
.end method

.method private a()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    iget-boolean v0, v0, Lchat/ola/vn/entity/l;->k:Z

    const/16 v1, 0x8

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->a:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->b:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->a:Landroid/view/View;

    invoke-virtual {v0, v3}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->b:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->a:Landroid/view/View;

    new-instance v4, Lchat/ola/vn/cloud/a$a$1;

    invoke-direct {v4, p0}, Lchat/ola/vn/cloud/a$a$1;-><init>(Lchat/ola/vn/cloud/a$a;)V

    invoke-virtual {v0, v4}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->a:Landroid/view/View;

    new-instance v4, Lchat/ola/vn/cloud/a$a$2;

    invoke-direct {v4, p0}, Lchat/ola/vn/cloud/a$a$2;-><init>(Lchat/ola/vn/cloud/a$a;)V

    invoke-virtual {v0, v4}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    iget-object v0, v0, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    iget-object v0, v0, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string v4, "http"

    invoke-virtual {v0, v4}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v4, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    sget v5, Lchat/ola/vn/e;->c:I

    div-int/lit8 v5, v5, 0x3

    sget v6, Lchat/ola/vn/e;->c:I

    div-int/lit8 v6, v6, 0x3

    invoke-virtual {v4, v5, v6}, Lchat/ola/vn/entity/l;->a(II)Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lchat/ola/vn/cloud/a$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v4, v5, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    iget-object v0, v0, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v0

    packed-switch v0, :pswitch_data_0

    goto :goto_2

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    sget-object v2, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    const v2, 0x7f080717

    goto :goto_1

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    sget-object v2, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    const v2, 0x7f08071a

    :goto_1
    invoke-virtual {v0, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setImageResource(I)V

    goto :goto_2

    :pswitch_2
    :try_start_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    iget-object v2, v2, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/cloud/a$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    const v5, 0x7f080714

    sget v6, Lchat/ola/vn/e;->c:I

    div-int/lit8 v6, v6, 0x3

    invoke-virtual {v0, v2, v4, v5, v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v2}, Lchat/ola/vn/view/OlaRatioImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    :catch_0
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    const-wide/high16 v4, 0x3ff0000000000000L    # 1.0

    invoke-virtual {v0, v4, v5}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    iget v0, v0, Lchat/ola/vn/entity/l;->g:I

    if-lez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->d:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    iget v1, v1, Lchat/ola/vn/entity/l;->g:I

    int-to-long v1, v1

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v1

    :goto_3
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    invoke-virtual {v0}, Lchat/ola/vn/entity/l;->a()Z

    move-result v0

    if-eqz v0, :cond_4

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_4

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->d:Landroid/widget/TextView;

    const-string v1, ""

    goto :goto_3

    :goto_4
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->e:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    iget-object v1, v1, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    iget-short v0, v0, Lchat/ola/vn/entity/l;->i:S

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    iget-short v0, v0, Lchat/ola/vn/entity/l;->j:S

    packed-switch v0, :pswitch_data_1

    return-void

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->d:Landroid/widget/TextView;

    const v1, 0x7f0806de

    goto :goto_5

    :pswitch_4
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->d:Landroid/widget/TextView;

    const v1, 0x7f0806df

    goto :goto_5

    :pswitch_5
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->d:Landroid/widget/TextView;

    const v1, 0x7f0806e0

    goto :goto_5

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    iget-short v0, v0, Lchat/ola/vn/entity/l;->i:S

    const/4 v1, 0x5

    if-ne v0, v1, :cond_6

    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->d:Landroid/widget/TextView;

    invoke-virtual {v0, v3, v3, v3, v3}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    return-void

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/cloud/a$a;->d:Landroid/widget/TextView;

    const v1, 0x7f0806dc

    :goto_5
    invoke-virtual {v0, v1, v3, v3, v3}, Landroid/widget/TextView;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
    .end packed-switch
.end method

.method static synthetic b(Lchat/ola/vn/cloud/a$a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/cloud/a$a;->a()V

    return-void
.end method


# virtual methods
.method protected a(Lchat/ola/vn/entity/l;)V
    .locals 0

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/cloud/a$a;->g:Lchat/ola/vn/entity/l;

    invoke-direct {p0}, Lchat/ola/vn/cloud/a$a;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
