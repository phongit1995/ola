.class public Lchat/ola/vn/g/e;
.super Lchat/ola/vn/g/a;


# instance fields
.field private d:Ljava/lang/CharSequence;


# direct methods
.method public constructor <init>(Ljava/lang/CharSequence;)V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/g/a;-><init>()V

    const/4 v0, 0x4

    iput v0, p0, Lchat/ola/vn/g/e;->a:I

    iput-object p1, p0, Lchat/ola/vn/g/e;->d:Ljava/lang/CharSequence;

    return-void
.end method


# virtual methods
.method public a(Landroid/view/LayoutInflater;)Landroid/view/View;
    .locals 2

    const v0, 0x7f0b00cf

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public a(Landroid/view/View;Lchat/ola/vn/g/h;)Lchat/ola/vn/g/h;
    .locals 2

    :try_start_0
    move-object v0, p2

    check-cast v0, Lchat/ola/vn/g/l;

    iget-object v1, p0, Lchat/ola/vn/g/e;->d:Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Lchat/ola/vn/g/l;->a(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    new-instance p2, Lchat/ola/vn/g/l;

    iget-object v0, p0, Lchat/ola/vn/g/e;->d:Ljava/lang/CharSequence;

    invoke-direct {p2, v0, p1}, Lchat/ola/vn/g/l;-><init>(Ljava/lang/CharSequence;Landroid/view/View;)V

    return-object p2
.end method
