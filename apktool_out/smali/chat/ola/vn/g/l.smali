.class public Lchat/ola/vn/g/l;
.super Lchat/ola/vn/g/h;


# instance fields
.field public e:Landroid/widget/TextView;

.field protected f:Ljava/lang/CharSequence;


# direct methods
.method public constructor <init>(Ljava/lang/CharSequence;Landroid/view/View;)V
    .locals 0

    invoke-direct {p0, p2}, Lchat/ola/vn/g/h;-><init>(Landroid/view/View;)V

    iput-object p1, p0, Lchat/ola/vn/g/l;->f:Ljava/lang/CharSequence;

    const p1, 0x7f0902ca

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/g/l;->e:Landroid/widget/TextView;

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/CharSequence;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/g/l;->f:Ljava/lang/CharSequence;

    return-void
.end method

.method public b(I)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/g/l;->f:Ljava/lang/CharSequence;

    invoke-static {p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/g/l;->e:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/g/l;->f:Ljava/lang/CharSequence;

    :goto_0
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/g/l;->e:Landroid/widget/TextView;

    const-string v0, ""

    goto :goto_0

    return-void
.end method
