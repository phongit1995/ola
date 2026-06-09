.class public abstract Lchat/ola/vn/g/a;
.super Ljava/lang/Object;


# instance fields
.field protected a:I

.field protected b:Z

.field protected c:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x7

    iput v0, p0, Lchat/ola/vn/g/a;->a:I

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/g/a;->b:Z

    iput-boolean v0, p0, Lchat/ola/vn/g/a;->c:Z

    return-void
.end method


# virtual methods
.method public a()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/g/a;->a:I

    return v0
.end method

.method public abstract a(Landroid/view/LayoutInflater;)Landroid/view/View;
.end method

.method public a(Landroid/view/View;Lchat/ola/vn/g/h;)Lchat/ola/vn/g/h;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/g/a;->b:Z

    return-void
.end method

.method public a(Landroid/content/Context;Landroid/view/View;IJ)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public b(Landroid/content/Context;Landroid/view/View;IJ)V
    .locals 0

    return-void
.end method

.method public b(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/g/a;->c:Z

    return-void
.end method
