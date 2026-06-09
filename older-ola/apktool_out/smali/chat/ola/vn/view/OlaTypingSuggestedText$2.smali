.class Lchat/ola/vn/view/OlaTypingSuggestedText$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/OlaTypingSuggestedText;->a(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/OlaTypingSuggestedText;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/OlaTypingSuggestedText;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    instance-of p2, p1, Lchat/ola/vn/entity/x;

    if-eqz p2, :cond_0

    :try_start_0
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    move-object p3, p1

    check-cast p3, Lchat/ola/vn/entity/x;

    iget-object p3, p3, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, " "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p3}, Lchat/ola/vn/view/OlaTypingSuggestedText;->getEditableText()Landroid/text/Editable;

    move-result-object p3

    if-eqz p3, :cond_0

    iget-object p4, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-static {p4}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a(Lchat/ola/vn/view/OlaTypingSuggestedText;)I

    move-result p4

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p5

    iget-object v0, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-static {v0}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a(Lchat/ola/vn/view/OlaTypingSuggestedText;)I

    move-result v0

    iget-object v1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-static {v1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->a(Lchat/ola/vn/view/OlaTypingSuggestedText;)I

    move-result v1

    iget-object v2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-static {v2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->b(Lchat/ola/vn/view/OlaTypingSuggestedText;)I

    move-result v2

    add-int/2addr v1, v2

    invoke-interface {p3, v0, v1, p2}, Landroid/text/Editable;->replace(IILjava/lang/CharSequence;)Landroid/text/Editable;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    add-int/2addr p4, p5

    invoke-virtual {p2, p4}, Lchat/ola/vn/view/OlaTypingSuggestedText;->setSelection(I)V

    iget-object p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-virtual {p2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->clearComposingText()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-static {p2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->c(Lchat/ola/vn/view/OlaTypingSuggestedText;)Z

    iget-object p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-static {p2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->d(Lchat/ola/vn/view/OlaTypingSuggestedText;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;

    move-result-object p2

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-static {p2}, Lchat/ola/vn/view/OlaTypingSuggestedText;->d(Lchat/ola/vn/view/OlaTypingSuggestedText;)Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;

    move-result-object p2

    check-cast p1, Lchat/ola/vn/entity/x;

    iget-object p1, p1, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    invoke-interface {p2, p1}, Lchat/ola/vn/view/OlaQuickTypingSuggestedText$b;->b_(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/OlaTypingSuggestedText$2;->a:Lchat/ola/vn/view/OlaTypingSuggestedText;

    invoke-static {p1}, Lchat/ola/vn/view/OlaTypingSuggestedText;->e(Lchat/ola/vn/view/OlaTypingSuggestedText;)Lcom/mg/ola/common/widget/b;

    move-result-object p1

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/b;->d()V

    return-void
.end method
