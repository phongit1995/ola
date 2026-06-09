.class final Lcom/mg/ola/a/a/b/k$4;
.super Lcom/mg/ola/a/a/a/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/a/a/b/k;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/mg/ola/a/a/a/b<",
        "Landroid/view/View;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/a/a/a/b;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public a(Landroid/view/View;)Ljava/lang/Integer;
    .locals 0

    invoke-static {p1}, Lcom/mg/ola/a/a/c/a;->a(Landroid/view/View;)Lcom/mg/ola/a/a/c/a;

    move-result-object p1

    invoke-virtual {p1}, Lcom/mg/ola/a/a/c/a;->j()I

    move-result p1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic a(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, Landroid/view/View;

    invoke-virtual {p0, p1}, Lcom/mg/ola/a/a/b/k$4;->a(Landroid/view/View;)Ljava/lang/Integer;

    move-result-object p1

    return-object p1
.end method

.method public a(Landroid/view/View;I)V
    .locals 0

    invoke-static {p1}, Lcom/mg/ola/a/a/c/a;->a(Landroid/view/View;)Lcom/mg/ola/a/a/c/a;

    move-result-object p1

    invoke-virtual {p1, p2}, Lcom/mg/ola/a/a/c/a;->b(I)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;I)V
    .locals 0

    check-cast p1, Landroid/view/View;

    invoke-virtual {p0, p1, p2}, Lcom/mg/ola/a/a/b/k$4;->a(Landroid/view/View;I)V

    return-void
.end method
