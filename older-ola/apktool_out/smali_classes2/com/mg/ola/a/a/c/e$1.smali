.class Lcom/mg/ola/a/a/c/e$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/animation/Animator$AnimatorListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mg/ola/a/a/c/e;->a(Lcom/mg/ola/a/a/b/a$a;)Lcom/mg/ola/a/a/c/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/a/a/b/a$a;

.field final synthetic b:Lcom/mg/ola/a/a/c/e;


# direct methods
.method constructor <init>(Lcom/mg/ola/a/a/c/e;Lcom/mg/ola/a/a/b/a$a;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/a/a/c/e$1;->b:Lcom/mg/ola/a/a/c/e;

    iput-object p2, p0, Lcom/mg/ola/a/a/c/e$1;->a:Lcom/mg/ola/a/a/b/a$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationCancel(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, Lcom/mg/ola/a/a/c/e$1;->a:Lcom/mg/ola/a/a/b/a$a;

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Lcom/mg/ola/a/a/b/a$a;->b(Lcom/mg/ola/a/a/b/a;)V

    return-void
.end method

.method public onAnimationEnd(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, Lcom/mg/ola/a/a/c/e$1;->a:Lcom/mg/ola/a/a/b/a$a;

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Lcom/mg/ola/a/a/b/a$a;->a(Lcom/mg/ola/a/a/b/a;)V

    return-void
.end method

.method public onAnimationRepeat(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, Lcom/mg/ola/a/a/c/e$1;->a:Lcom/mg/ola/a/a/b/a$a;

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Lcom/mg/ola/a/a/b/a$a;->d(Lcom/mg/ola/a/a/b/a;)V

    return-void
.end method

.method public onAnimationStart(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, Lcom/mg/ola/a/a/c/e$1;->a:Lcom/mg/ola/a/a/b/a$a;

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Lcom/mg/ola/a/a/b/a$a;->c(Lcom/mg/ola/a/a/b/a;)V

    return-void
.end method
