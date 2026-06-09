.class public Lchat/ola/vn/g/f;
.super Lchat/ola/vn/g/a;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/g/a;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/g/f;->a:I

    return-void
.end method


# virtual methods
.method public a(Landroid/view/LayoutInflater;)Landroid/view/View;
    .locals 2

    const v0, 0x7f0b007a

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public a(Landroid/view/View;Lchat/ola/vn/g/h;)Lchat/ola/vn/g/h;
    .locals 0

    if-nez p2, :cond_0

    new-instance p2, Lchat/ola/vn/g/m;

    invoke-direct {p2, p1}, Lchat/ola/vn/g/m;-><init>(Landroid/view/View;)V

    :cond_0
    return-object p2
.end method
