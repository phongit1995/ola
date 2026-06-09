.class Lchat/ola/vn/b/aj$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/aj;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# instance fields
.field public a:Lchat/ola/vn/view/OlaRatioImageView;

.field public b:Landroid/widget/TextView;

.field public c:Landroid/widget/TextView;

.field public d:Landroid/view/View;

.field private e:Lchat/ola/vn/entity/t;


# direct methods
.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Lchat/ola/vn/entity/t;IIS)Landroid/view/View;
    .locals 0

    const p2, 0x7f0b019f

    const/4 p3, 0x0

    packed-switch p4, :pswitch_data_0

    if-eqz p5, :cond_1

    const/4 p4, 0x1

    if-ne p5, p4, :cond_0

    goto :goto_1

    :pswitch_0
    const p2, 0x7f0b01a0

    goto :goto_0

    :pswitch_1
    const p2, 0x7f0b01a1

    :cond_0
    :goto_0
    :pswitch_2
    invoke-virtual {p0, p2, p1, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p0

    goto :goto_2

    :cond_1
    :goto_1
    const p2, 0x7f0b01a4

    goto :goto_0

    :goto_2
    new-instance p1, Lchat/ola/vn/b/aj$a;

    invoke-direct {p1}, Lchat/ola/vn/b/aj$a;-><init>()V

    const p2, 0x7f09029e

    invoke-virtual {p0, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaRatioImageView;

    iput-object p2, p1, Lchat/ola/vn/b/aj$a;->a:Lchat/ola/vn/view/OlaRatioImageView;

    const p2, 0x7f09056e

    invoke-virtual {p0, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p1, Lchat/ola/vn/b/aj$a;->b:Landroid/widget/TextView;

    :try_start_0
    iget-object p2, p1, Lchat/ola/vn/b/aj$a;->a:Lchat/ola/vn/view/OlaRatioImageView;

    sget p3, Lchat/ola/vn/e;->d:I

    invoke-virtual {p2, p3}, Lchat/ola/vn/view/OlaRatioImageView;->setMaxHeight(I)V

    const p2, 0x7f09056c

    invoke-virtual {p0, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p1, Lchat/ola/vn/b/aj$a;->c:Landroid/widget/TextView;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const p2, 0x7f0904a3

    :try_start_1
    invoke-virtual {p0, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, p1, Lchat/ola/vn/b/aj$a;->d:Landroid/view/View;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    invoke-virtual {p0, p1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-object p0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private a(I)Z
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/b/aj$a;->e:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->h()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/aj$a;->a:Lchat/ola/vn/view/OlaRatioImageView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0, v0}, Lchat/ola/vn/view/OlaRatioImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/b/aj$a;->a:Lchat/ola/vn/view/OlaRatioImageView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    return v1

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/aj$a;->a:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaRatioImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/b/aj$a;->e:Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->h()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/b/aj$a;->a:Lchat/ola/vn/view/OlaRatioImageView;

    invoke-virtual {v0, v1, v2, p1}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const/4 p1, 0x1

    return p1
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/t;I)V
    .locals 2

    :try_start_0
    sget p2, Lchat/ola/vn/e;->c:I

    sget v0, Lchat/ola/vn/e;->d:I

    invoke-static {p2, v0}, Ljava/lang/Math;->max(II)I

    move-result p2

    iput-object p1, p0, Lchat/ola/vn/b/aj$a;->e:Lchat/ola/vn/entity/t;

    iget-object v0, p0, Lchat/ola/vn/b/aj$a;->b:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/b/aj$a;->e:Lchat/ola/vn/entity/t;

    invoke-virtual {v1}, Lchat/ola/vn/entity/t;->p()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/b/aj$a;->e:Lchat/ola/vn/entity/t;

    invoke-virtual {v0}, Lchat/ola/vn/entity/t;->n()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/b/aj$a;->d:Landroid/view/View;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/aj$a;->d:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/aj$a;->c:Landroid/widget/TextView;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/b/aj$a;->c:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/b/aj$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->n()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/b/aj$a;->d:Landroid/view/View;

    const/16 v0, 0x8

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/b/aj$a;->d:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/b/aj$a;->c:Landroid/widget/TextView;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/b/aj$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_3
    :goto_0
    invoke-direct {p0, p2}, Lchat/ola/vn/b/aj$a;->a(I)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
