.class public abstract Lchat/ola/vn/g/h;
.super Ljava/lang/Object;


# instance fields
.field protected a:Z

.field protected b:Z

.field protected c:Landroid/view/View;

.field protected d:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/g/h;->a:Z

    iput-boolean v0, p0, Lchat/ola/vn/g/h;->b:Z

    const v0, 0x7f09030a

    :try_start_0
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/g/h;->d:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public final a(I)V
    .locals 3

    const/4 v0, 0x0

    const/16 v1, 0x8

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/g/h;->b()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/g/h;->c:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/g/h;->c:Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :goto_0
    :try_start_1
    invoke-virtual {p0}, Lchat/ola/vn/g/h;->a()Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v0, p0, Lchat/ola/vn/g/h;->d:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/g/h;->d:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :goto_1
    invoke-virtual {p0, p1}, Lchat/ola/vn/g/h;->b(I)V

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/g/h;->a:Z

    return-void
.end method

.method public a()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/g/h;->a:Z

    return v0
.end method

.method public b(I)V
    .locals 0

    return-void
.end method

.method public b(Z)V
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/g/h;->b:Z

    return-void
.end method

.method public b()Z
    .locals 1

    iget-boolean v0, p0, Lchat/ola/vn/g/h;->b:Z

    return v0
.end method
