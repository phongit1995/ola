.class Lchat/ola/vn/b/an$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/an;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Landroid/widget/ImageView;

.field b:Landroid/widget/TextView;

.field final synthetic c:Lchat/ola/vn/b/an;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/an;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/an$a;->c:Lchat/ola/vn/b/an;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f09029a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/b/an$a;->a:Landroid/widget/ImageView;

    const p1, 0x7f09055d

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/an$a;->b:Landroid/widget/TextView;

    invoke-virtual {p2, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/af;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/an$a;->b:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entity/af;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/b/an$a;->a:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/af;->c()I

    move-result v0

    if-nez v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/an$a;->a:Landroid/widget/ImageView;

    const v0, 0x7f0806d8

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/an$a;->a:Landroid/widget/ImageView;

    invoke-virtual {p1}, Lchat/ola/vn/entity/af;->c()I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void
.end method
