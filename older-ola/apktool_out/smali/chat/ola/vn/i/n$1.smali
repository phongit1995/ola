.class Lchat/ola/vn/i/n$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/n;->show()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/view/View;

.field final synthetic b:Lchat/ola/vn/i/n;


# direct methods
.method constructor <init>(Lchat/ola/vn/i/n;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    iput-object p2, p0, Lchat/ola/vn/i/n$1;->a:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/i/n$1;->a:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getHeight()I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/i/n$1;->a:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getWidth()I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-virtual {v2}, Lchat/ola/vn/i/n;->b()V

    iget-object v2, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-virtual {v2}, Lchat/ola/vn/i/n;->getWindow()Landroid/view/Window;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v2

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->width:I

    iget-object v3, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-virtual {v3}, Lchat/ola/vn/i/n;->getWindow()Landroid/view/Window;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v3

    iget v3, v3, Landroid/view/WindowManager$LayoutParams;->height:I

    sget v4, Lchat/ola/vn/e;->c:I

    iget-object v5, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-static {v5}, Lchat/ola/vn/i/n;->a(Lchat/ola/vn/i/n;)I

    move-result v5

    sub-int/2addr v4, v5

    iget-object v5, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-static {v5}, Lchat/ola/vn/i/n;->b(Lchat/ola/vn/i/n;)I

    move-result v5

    sub-int/2addr v4, v5

    if-le v1, v4, :cond_0

    sget v1, Lchat/ola/vn/e;->c:I

    iget-object v2, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-static {v2}, Lchat/ola/vn/i/n;->a(Lchat/ola/vn/i/n;)I

    move-result v2

    sub-int/2addr v1, v2

    iget-object v2, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-static {v2}, Lchat/ola/vn/i/n;->b(Lchat/ola/vn/i/n;)I

    move-result v2

    sub-int v2, v1, v2

    :cond_0
    sget v1, Lchat/ola/vn/e;->d:I

    iget-object v4, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-static {v4}, Lchat/ola/vn/i/n;->c(Lchat/ola/vn/i/n;)I

    move-result v4

    sub-int/2addr v1, v4

    iget-object v4, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-static {v4}, Lchat/ola/vn/i/n;->d(Lchat/ola/vn/i/n;)I

    move-result v4

    sub-int/2addr v1, v4

    if-lt v0, v1, :cond_1

    sget v0, Lchat/ola/vn/e;->d:I

    iget-object v1, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-static {v1}, Lchat/ola/vn/i/n;->c(Lchat/ola/vn/i/n;)I

    move-result v1

    sub-int/2addr v0, v1

    iget-object v1, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-static {v1}, Lchat/ola/vn/i/n;->d(Lchat/ola/vn/i/n;)I

    move-result v1

    sub-int v3, v0, v1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    invoke-virtual {v0}, Lchat/ola/vn/i/n;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2, v3}, Landroid/view/Window;->setLayout(II)V

    iget-object v0, p0, Lchat/ola/vn/i/n$1;->b:Lchat/ola/vn/i/n;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lchat/ola/vn/i/n;->i:Z

    return-void
.end method
