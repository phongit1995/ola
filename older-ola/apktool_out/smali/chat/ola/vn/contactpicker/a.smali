.class Lchat/ola/vn/contactpicker/a;
.super Landroid/widget/BaseAdapter;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/contactpicker/a$b;,
        Lchat/ola/vn/contactpicker/a$a;
    }
.end annotation


# instance fields
.field protected a:Landroid/view/LayoutInflater;

.field public b:Lchat/ola/vn/contactpicker/OlaContactPickerActivity$c;

.field private final c:B

.field private final d:B

.field private e:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/contactpicker/a$b;",
            ">;"
        }
    .end annotation
.end field

.field private f:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    const/4 v0, 0x0

    iput-byte v0, p0, Lchat/ola/vn/contactpicker/a;->c:B

    const/4 v0, 0x1

    iput-byte v0, p0, Lchat/ola/vn/contactpicker/a;->d:B

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/contactpicker/a;->a:Landroid/view/LayoutInflater;

    iput-object p1, p0, Lchat/ola/vn/contactpicker/a;->f:Landroid/content/Context;

    return-void
.end method

.method private b(Ljava/util/List;)V
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    const/16 v0, 0x40

    new-instance v1, Lchat/ola/vn/e/f;

    invoke-direct {v1}, Lchat/ola/vn/e/f;-><init>()V

    invoke-static {p1, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v5, v2

    const/4 v0, 0x0

    const/16 v4, 0x40

    :goto_0
    if-ge v0, v1, :cond_3

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lchat/ola/vn/message/f;

    invoke-virtual {v6}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, v3}, Ljava/lang/String;->charAt(I)C

    move-result v7

    const/4 v8, 0x1

    if-eq v7, v4, :cond_2

    new-instance v4, Lchat/ola/vn/contactpicker/a$b;

    invoke-direct {v4, p0, v2}, Lchat/ola/vn/contactpicker/a$b;-><init>(Lchat/ola/vn/contactpicker/a;Lchat/ola/vn/contactpicker/a$1;)V

    iput-byte v8, v4, Lchat/ola/vn/contactpicker/a$b;->a:B

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const-string v10, ""

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    sget-object v10, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v9, v10}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v9

    iput-object v9, v4, Lchat/ola/vn/contactpicker/a$b;->b:Ljava/lang/String;

    iget-object v9, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    invoke-interface {v9, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    if-eqz v5, :cond_1

    iput-boolean v8, v5, Lchat/ola/vn/contactpicker/a$b;->f:Z

    :cond_1
    move v4, v7

    goto :goto_1

    :cond_2
    const/4 v8, 0x0

    :goto_1
    new-instance v5, Lchat/ola/vn/contactpicker/a$b;

    invoke-direct {v5, p0, v2}, Lchat/ola/vn/contactpicker/a$b;-><init>(Lchat/ola/vn/contactpicker/a;Lchat/ola/vn/contactpicker/a$1;)V

    iput-byte v3, v5, Lchat/ola/vn/contactpicker/a$b;->a:B

    iput-object v6, v5, Lchat/ola/vn/contactpicker/a$b;->c:Lchat/ola/vn/message/f;

    iput-boolean v8, v5, Lchat/ola/vn/contactpicker/a$b;->e:Z

    iput-boolean v3, v5, Lchat/ola/vn/contactpicker/a$b;->f:Z

    iget-object v6, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    invoke-interface {v6, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_3
    return-void
.end method


# virtual methods
.method public a(I)Lchat/ola/vn/contactpicker/a$b;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/contactpicker/a$b;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Lchat/ola/vn/message/f;)V
    .locals 5

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_1

    iget-object v2, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/contactpicker/a$b;

    iget-object v3, v2, Lchat/ola/vn/contactpicker/a$b;->c:Lchat/ola/vn/message/f;

    if-eqz v3, :cond_0

    iget-object v3, v2, Lchat/ola/vn/contactpicker/a$b;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 p1, 0x1

    iput-boolean p1, v2, Lchat/ola/vn/contactpicker/a$b;->d:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-direct {p0, p1}, Lchat/ola/vn/contactpicker/a;->b(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;)I
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    :goto_0
    if-ge v0, v1, :cond_1

    iget-object v2, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/contactpicker/a$b;

    iget-object v3, v2, Lchat/ola/vn/contactpicker/a$b;->c:Lchat/ola/vn/message/f;

    if-eqz v3, :cond_0

    iget-object v2, v2, Lchat/ola/vn/contactpicker/a$b;->c:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v2, :cond_0

    return v0

    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    const/4 p1, -0x1

    return p1
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/contactpicker/a;->a(I)Lchat/ola/vn/contactpicker/a$b;

    move-result-object p1

    return-object p1
.end method

.method public getItemId(I)J
    .locals 2

    int-to-long v0, p1

    return-wide v0
.end method

.method public getItemViewType(I)I
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/contactpicker/a;->a(I)Lchat/ola/vn/contactpicker/a$b;

    move-result-object p1

    iget-byte p1, p1, Lchat/ola/vn/contactpicker/a$b;->a:B

    return p1
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 5

    :try_start_0
    iget-object p3, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    invoke-interface {p3, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/contactpicker/a$b;

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-nez p2, :cond_1

    iget-byte v2, p3, Lchat/ola/vn/contactpicker/a$b;->a:B

    if-ne v2, v0, :cond_0

    iget-object v2, p0, Lchat/ola/vn/contactpicker/a;->a:Landroid/view/LayoutInflater;

    const v3, 0x7f0b00cf

    invoke-virtual {v2, v3, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    :goto_0
    move-object p2, v2

    goto :goto_1

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/contactpicker/a;->a:Landroid/view/LayoutInflater;

    const v3, 0x7f0b0076

    invoke-virtual {v2, v3, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    goto :goto_0

    :goto_1
    new-instance v2, Lchat/ola/vn/contactpicker/a$a;

    invoke-direct {v2, p0, p2}, Lchat/ola/vn/contactpicker/a$a;-><init>(Lchat/ola/vn/contactpicker/a;Landroid/view/View;)V

    invoke-virtual {p2, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    goto :goto_2

    :cond_1
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    :try_start_1
    check-cast v2, Lchat/ola/vn/contactpicker/a$a;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-exception v2

    :try_start_2
    new-instance v3, Lchat/ola/vn/contactpicker/a$a;

    invoke-direct {v3, p0, p2}, Lchat/ola/vn/contactpicker/a$a;-><init>(Lchat/ola/vn/contactpicker/a;Landroid/view/View;)V

    invoke-virtual {p2, v3}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    invoke-virtual {v2}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_3

    move-object v2, v3

    :goto_2
    :try_start_3
    iget-object v3, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    add-int/lit8 v4, p1, -0x1

    invoke-interface {v3, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/contactpicker/a$b;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_3

    :catch_1
    move-object v3, v1

    :goto_3
    :try_start_4
    iget-object v4, p0, Lchat/ola/vn/contactpicker/a;->e:Ljava/util/List;

    add-int/2addr p1, v0

    invoke-interface {v4, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/contactpicker/a$b;
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_4

    :catch_2
    move-object p1, v1

    :goto_4
    :try_start_5
    invoke-virtual {v2, p3, v3, p1}, Lchat/ola/vn/contactpicker/a$a;->a(Lchat/ola/vn/contactpicker/a$b;Lchat/ola/vn/contactpicker/a$b;Lchat/ola/vn/contactpicker/a$b;)V
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    return-object p2

    :catch_3
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-object p2
.end method

.method public getViewTypeCount()I
    .locals 1

    const/4 v0, 0x2

    return v0
.end method
