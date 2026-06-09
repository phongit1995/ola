.class public Lchat/ola/vn/cloud/c$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/cloud/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation


# instance fields
.field protected a:Landroid/view/View;

.field protected b:Landroid/widget/TextView;

.field protected c:Lchat/ola/vn/view/OlaRatioImageView;

.field final synthetic d:Lchat/ola/vn/cloud/c;

.field private e:Lchat/ola/vn/entity/i;


# direct methods
.method protected constructor <init>(Lchat/ola/vn/cloud/c;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/c$a;->d:Lchat/ola/vn/cloud/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f090182

    :try_start_0
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/cloud/c$a;->a:Landroid/view/View;

    const p1, 0x7f09017e

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/cloud/c$a;->b:Landroid/widget/TextView;

    const p1, 0x7f090180

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object p1, p0, Lchat/ola/vn/cloud/c$a;->c:Lchat/ola/vn/view/OlaRatioImageView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/cloud/c$a;)Lchat/ola/vn/entity/i;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/cloud/c$a;->e:Lchat/ola/vn/entity/i;

    return-object p0
.end method

.method private a()V
    .locals 5

    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->e:Lchat/ola/vn/entity/i;

    invoke-virtual {v0}, Lchat/ola/vn/entity/i;->b()Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->a:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->b:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->b:Landroid/widget/TextView;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lchat/ola/vn/cloud/c$a;->e:Lchat/ola/vn/entity/i;

    invoke-virtual {v4}, Lchat/ola/vn/entity/i;->a()I

    move-result v4

    add-int/2addr v4, v2

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->a:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setSelected(Z)V

    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->b:Landroid/widget/TextView;

    const/16 v3, 0x8

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->a:Landroid/view/View;

    new-instance v3, Lchat/ola/vn/cloud/c$a$1;

    invoke-direct {v3, p0}, Lchat/ola/vn/cloud/c$a$1;-><init>(Lchat/ola/vn/cloud/c$a;)V

    invoke-virtual {v0, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->a:Landroid/view/View;

    new-instance v3, Lchat/ola/vn/cloud/c$a$2;

    invoke-direct {v3, p0}, Lchat/ola/vn/cloud/c$a$2;-><init>(Lchat/ola/vn/cloud/c$a;)V

    invoke-virtual {v0, v3}, Landroid/view/View;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->e:Lchat/ola/vn/entity/i;

    invoke-virtual {v0}, Lchat/ola/vn/entity/i;->h()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/cloud/c$a;->e:Lchat/ola/vn/entity/i;

    invoke-virtual {v1}, Lchat/ola/vn/entity/i;->h()Ljava/lang/String;

    move-result-object v1

    sget v3, Lchat/ola/vn/e;->c:I

    div-int/lit8 v3, v3, 0x3

    sget v4, Lchat/ola/vn/e;->c:I

    div-int/lit8 v4, v4, 0x3

    invoke-static {v1, v3, v4}, Lchat/ola/vn/entity/l;->a(Ljava/lang/String;II)Ljava/lang/String;

    move-result-object v1

    iget-object v3, p0, Lchat/ola/vn/cloud/c$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v1, v3, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->e:Lchat/ola/vn/entity/i;

    invoke-virtual {v0}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->e:Lchat/ola/vn/entity/i;

    invoke-virtual {v0}, Lchat/ola/vn/entity/i;->f()S

    move-result v0

    packed-switch v0, :pswitch_data_0

    goto :goto_2

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    const v1, 0x7f080717

    goto :goto_1

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    const v1, 0x7f08071a

    :goto_1
    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setImageResource(I)V

    goto :goto_2

    :pswitch_2
    :try_start_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p0, Lchat/ola/vn/cloud/c$a;->e:Lchat/ola/vn/entity/i;

    invoke-virtual {v2}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/cloud/c$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    sget v4, Lchat/ola/vn/e;->c:I

    div-int/lit8 v4, v4, 0x3

    invoke-virtual {v0, v2, v3, v1, v4}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1}, Lchat/ola/vn/view/OlaRatioImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    :catch_0
    :goto_2
    iget-object v0, p0, Lchat/ola/vn/cloud/c$a;->c:Lchat/ola/vn/view/OlaRatioImageView;

    const-wide/high16 v1, 0x3ff0000000000000L    # 1.0

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method


# virtual methods
.method protected a(Lchat/ola/vn/entity/i;)V
    .locals 0

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/cloud/c$a;->e:Lchat/ola/vn/entity/i;

    invoke-direct {p0}, Lchat/ola/vn/cloud/c$a;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
