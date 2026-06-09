.class Lcom/mg/ola/common/c/c$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/ViewTreeObserver$OnScrollChangedListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mg/ola/common/c/c;-><init>(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/reflect/Field;

.field final synthetic b:Landroid/view/ViewTreeObserver$OnScrollChangedListener;

.field final synthetic c:Lcom/mg/ola/common/c/c;


# direct methods
.method constructor <init>(Lcom/mg/ola/common/c/c;Ljava/lang/reflect/Field;Landroid/view/ViewTreeObserver$OnScrollChangedListener;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/c/c$1;->c:Lcom/mg/ola/common/c/c;

    iput-object p2, p0, Lcom/mg/ola/common/c/c$1;->a:Ljava/lang/reflect/Field;

    iput-object p3, p0, Lcom/mg/ola/common/c/c$1;->b:Landroid/view/ViewTreeObserver$OnScrollChangedListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onScrollChanged()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lcom/mg/ola/common/c/c$1;->a:Ljava/lang/reflect/Field;

    iget-object v1, p0, Lcom/mg/ola/common/c/c$1;->c:Lcom/mg/ola/common/c/c;

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/common/c/c$1;->b:Landroid/view/ViewTreeObserver$OnScrollChangedListener;

    invoke-interface {v0}, Landroid/view/ViewTreeObserver$OnScrollChangedListener;->onScrollChanged()V
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    return-void
.end method
