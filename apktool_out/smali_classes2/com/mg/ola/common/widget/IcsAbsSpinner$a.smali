.class Lcom/mg/ola/common/widget/IcsAbsSpinner$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/IcsAbsSpinner;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/IcsAbsSpinner;

.field private final b:Landroid/util/SparseArray;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/SparseArray<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>(Lcom/mg/ola/common/widget/IcsAbsSpinner;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner$a;->a:Lcom/mg/ola/common/widget/IcsAbsSpinner;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance p1, Landroid/util/SparseArray;

    invoke-direct {p1}, Landroid/util/SparseArray;-><init>()V

    iput-object p1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner$a;->b:Landroid/util/SparseArray;

    return-void
.end method


# virtual methods
.method a(I)Landroid/view/View;
    .locals 2

    iget-object v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner$a;->b:Landroid/util/SparseArray;

    invoke-virtual {v0, p1}, Landroid/util/SparseArray;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner$a;->b:Landroid/util/SparseArray;

    invoke-virtual {v1, p1}, Landroid/util/SparseArray;->delete(I)V

    :cond_0
    return-object v0
.end method

.method public a(ILandroid/view/View;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/IcsAbsSpinner$a;->b:Landroid/util/SparseArray;

    invoke-virtual {v0, p1, p2}, Landroid/util/SparseArray;->put(ILjava/lang/Object;)V

    return-void
.end method
