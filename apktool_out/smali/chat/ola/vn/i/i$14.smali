.class final Lchat/ola/vn/i/i$14;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/i/i;->a(Landroid/content/Context;Lchat/ola/vn/entity/i;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Lchat/ola/vn/entity/i;


# direct methods
.method constructor <init>(Ljava/util/List;Landroid/content/Context;Lchat/ola/vn/entity/i;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/i$14;->a:Ljava/util/List;

    iput-object p2, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    iput-object p3, p0, Lchat/ola/vn/i/i$14;->c:Lchat/ola/vn/entity/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/i/i$14;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    const p3, 0x7f0f04c7

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    iget-object p2, p0, Lchat/ola/vn/i/i$14;->c:Lchat/ola/vn/entity/i;

    invoke-virtual {p2}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/b/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    const p3, 0x7f0f05b2

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    iget-object p2, p0, Lchat/ola/vn/i/i$14;->c:Lchat/ola/vn/entity/i;

    invoke-virtual {p2}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->c(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    const p3, 0x7f0f0491

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/i/i$14;->c:Lchat/ola/vn/entity/i;

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_5

    iget-object p2, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "#\u001b"

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "#"

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_0
    invoke-static {p2, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    const p3, 0x7f0f0493

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_4

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "#\u001b"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p2, p0, Lchat/ola/vn/i/i$14;->c:Lchat/ola/vn/entity/i;

    invoke-virtual {p2}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "#"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_5

    iget-object p2, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    invoke-static {p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_3

    goto :goto_1

    :cond_3
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, " "

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_1
    iget-object p2, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    goto :goto_0

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    const p3, 0x7f0f056b

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/i/i$14;->b:Landroid/content/Context;

    iget-object p2, p0, Lchat/ola/vn/i/i$14;->c:Lchat/ola/vn/entity/i;

    invoke-static {p1, p2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Lchat/ola/vn/entity/i;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_5
    return-void
.end method
