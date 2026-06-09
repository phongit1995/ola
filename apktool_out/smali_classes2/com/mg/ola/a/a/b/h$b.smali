.class Lcom/mg/ola/a/a/b/h$b;
.super Lcom/mg/ola/a/a/b/h;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/a/a/b/h;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "b"
.end annotation


# instance fields
.field d:I


# direct methods
.method constructor <init>(F)V
    .locals 0

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/h;-><init>()V

    iput p1, p0, Lcom/mg/ola/a/a/b/h$b;->a:F

    sget-object p1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    iput-object p1, p0, Lcom/mg/ola/a/a/b/h$b;->b:Ljava/lang/Class;

    return-void
.end method

.method constructor <init>(FI)V
    .locals 0

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/h;-><init>()V

    iput p1, p0, Lcom/mg/ola/a/a/b/h$b;->a:F

    iput p2, p0, Lcom/mg/ola/a/a/b/h$b;->d:I

    sget-object p1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    iput-object p1, p0, Lcom/mg/ola/a/a/b/h$b;->b:Ljava/lang/Class;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/mg/ola/a/a/b/h$b;->c:Z

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;)V
    .locals 2

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-class v1, Ljava/lang/Integer;

    if-ne v0, v1, :cond_0

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, p0, Lcom/mg/ola/a/a/b/h$b;->d:I

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/mg/ola/a/a/b/h$b;->c:Z

    :cond_0
    return-void
.end method

.method public b()Ljava/lang/Object;
    .locals 1

    iget v0, p0, Lcom/mg/ola/a/a/b/h$b;->d:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    return-object v0
.end method

.method public synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/h$b;->g()Lcom/mg/ola/a/a/b/h$b;

    move-result-object v0

    return-object v0
.end method

.method public synthetic e()Lcom/mg/ola/a/a/b/h;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/h$b;->g()Lcom/mg/ola/a/a/b/h$b;

    move-result-object v0

    return-object v0
.end method

.method public f()I
    .locals 1

    iget v0, p0, Lcom/mg/ola/a/a/b/h$b;->d:I

    return v0
.end method

.method public g()Lcom/mg/ola/a/a/b/h$b;
    .locals 3

    new-instance v0, Lcom/mg/ola/a/a/b/h$b;

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/h$b;->c()F

    move-result v1

    iget v2, p0, Lcom/mg/ola/a/a/b/h$b;->d:I

    invoke-direct {v0, v1, v2}, Lcom/mg/ola/a/a/b/h$b;-><init>(FI)V

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/h$b;->d()Landroid/view/animation/Interpolator;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mg/ola/a/a/b/h$b;->a(Landroid/view/animation/Interpolator;)V

    return-object v0
.end method
