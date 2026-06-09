.class Lchat/ola/vn/m/o$6;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/o;->a(Lchat/ola/vn/message/f;Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/message/f;

.field final synthetic c:Landroid/content/Context;

.field final synthetic d:Lchat/ola/vn/m/o;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/o;Ljava/util/List;Lchat/ola/vn/message/f;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    iput-object p2, p0, Lchat/ola/vn/m/o$6;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/m/o$6;->b:Lchat/ola/vn/message/f;

    iput-object p4, p0, Lchat/ola/vn/m/o$6;->c:Landroid/content/Context;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 6
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
    iget-object p1, p0, Lchat/ola/vn/m/o$6;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    const p3, 0x7f0f05af

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p3, 0x1

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/m/o$6;->b:Lchat/ola/vn/message/f;

    invoke-static {p3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p4

    invoke-virtual {p2, p4}, Lchat/ola/vn/message/f;->a(Ljava/lang/Boolean;)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz p2, :cond_0

    sget-object p2, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object p4, p0, Lchat/ola/vn/m/o$6;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p2, p4}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/message/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object p4, p0, Lchat/ola/vn/m/o$6;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p2, p4}, Lchat/ola/vn/message/g;->c(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    sget-object p2, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object p4, p0, Lchat/ola/vn/m/o$6;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p2, p4}, Lchat/ola/vn/balloon/OlaBalloonService;->c(Lchat/ola/vn/message/f;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_0
    :try_start_3
    iget-object p2, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    const p4, 0x7f0f04ad

    invoke-virtual {p2, p4}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    new-instance p1, Lchat/ola/vn/i/h;

    iget-object p2, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    invoke-virtual {p2}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    const p4, 0x7f0f009c

    invoke-virtual {p3, p4}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p3

    iget-object p4, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    const p5, 0x7f0f021c

    invoke-virtual {p4, p5}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p4

    new-instance p5, Lchat/ola/vn/m/o$6$1;

    invoke-direct {p5, p0}, Lchat/ola/vn/m/o$6$1;-><init>(Lchat/ola/vn/m/o$6;)V

    invoke-direct {p1, p2, p3, p4, p5}, Lchat/ola/vn/i/h;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/i/h$a;)V

    invoke-virtual {p1}, Lchat/ola/vn/i/h;->show()V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    const p4, 0x7f0f0492

    invoke-virtual {p2, p4}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/m/o$6;->c:Landroid/content/Context;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "@"

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p3, p0, Lchat/ola/vn/m/o$6;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    const p4, 0x7f0f043a

    invoke-virtual {p2, p4}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object v0, p0, Lchat/ola/vn/m/o$6;->c:Landroid/content/Context;

    iget-object p1, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    const p2, 0x7f0f0184

    invoke-virtual {p1, p2}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p1, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    const p2, 0x7f0f0183

    new-array p3, p3, [Ljava/lang/Object;

    const/4 p4, 0x0

    new-instance p5, Ljava/lang/StringBuilder;

    invoke-direct {p5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "@"

    invoke-virtual {p5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/m/o$6;->b:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p5

    aput-object p5, p3, p4

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/m/o;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    const p2, 0x7f0f0439

    invoke-virtual {p1, p2}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    const p2, 0x7f0f044d

    invoke-virtual {p1, p2}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/m/o$6$2;

    invoke-direct {v5, p0}, Lchat/ola/vn/m/o$6$2;-><init>(Lchat/ola/vn/m/o$6;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    const p3, 0x7f0f042f

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/m/o$6;->d:Lchat/ola/vn/m/o;

    invoke-virtual {p1}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/m/o$6;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;)Lchat/ola/vn/i/p;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    :cond_4
    return-void
.end method
