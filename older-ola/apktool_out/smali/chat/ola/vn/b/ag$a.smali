.class Lchat/ola/vn/b/ag$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/ag;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Lchat/ola/vn/view/OlaCachedImageView;

.field b:Landroid/widget/TextView;

.field final synthetic c:Lchat/ola/vn/b/ag;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/ag;Landroid/view/View;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/b/ag$a;->c:Lchat/ola/vn/b/ag;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f09029a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/ag$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f09055d

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/ag$a;->b:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/b/ag$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/b/ag$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f080797

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    invoke-virtual {p2, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/t;)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/ag$a;->b:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->l()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
