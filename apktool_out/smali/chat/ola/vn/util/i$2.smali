.class final Lchat/ola/vn/util/i$2;
.super Lcom/mg/ola/common/d/a/a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/i;->b(Landroid/view/View;Ljava/lang/CharSequence;Lcom/mg/ola/common/widget/OlaTextView$b;IZ)Ljava/lang/CharSequence;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/OlaTextView$b;

.field final synthetic b:Landroid/view/View;

.field final synthetic c:Ljava/lang/String;


# direct methods
.method constructor <init>(IZLcom/mg/ola/common/widget/OlaTextView$b;Landroid/view/View;Ljava/lang/String;)V
    .locals 0

    iput-object p3, p0, Lchat/ola/vn/util/i$2;->a:Lcom/mg/ola/common/widget/OlaTextView$b;

    iput-object p4, p0, Lchat/ola/vn/util/i$2;->b:Landroid/view/View;

    iput-object p5, p0, Lchat/ola/vn/util/i$2;->c:Ljava/lang/String;

    invoke-direct {p0, p1, p2}, Lcom/mg/ola/common/d/a/a;-><init>(IZ)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    iget-object p1, p0, Lchat/ola/vn/util/i$2;->a:Lcom/mg/ola/common/widget/OlaTextView$b;

    iget-object v0, p0, Lchat/ola/vn/util/i$2;->b:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/util/i$2;->c:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-interface {p1, v0, v2, v1}, Lcom/mg/ola/common/widget/OlaTextView$b;->a(Landroid/view/View;Landroid/text/style/ClickableSpan;Ljava/lang/CharSequence;)V

    return-void
.end method
