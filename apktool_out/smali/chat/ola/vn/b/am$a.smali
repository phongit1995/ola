.class Lchat/ola/vn/b/am$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/am;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Lchat/ola/vn/view/OlaCachedImageView;

.field b:Landroid/widget/TextView;

.field final synthetic c:Lchat/ola/vn/b/am;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/am;Landroid/view/View;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/b/am$a;->c:Lchat/ola/vn/b/am;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f09029a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/am$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object p1, p0, Lchat/ola/vn/b/am$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    const p1, 0x7f09055d

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/am$a;->b:Landroid/widget/TextView;

    invoke-virtual {p2, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method

.method private a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V
    .locals 1

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/am$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p2, 0x7f0806d8

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0, p2, p1}, Lchat/ola/vn/c/t;->c(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/e;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/am$a;->b:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/b/am$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->e()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, v0, p1}, Lchat/ola/vn/b/am$a;->a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;)V

    return-void
.end method
