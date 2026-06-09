.class Lchat/ola/vn/pickercontacts/h$a;
.super Landroid/widget/Filter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/pickercontacts/h;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/pickercontacts/h;


# direct methods
.method private constructor <init>(Lchat/ola/vn/pickercontacts/h;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    invoke-direct {p0}, Landroid/widget/Filter;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/pickercontacts/h;Lchat/ola/vn/pickercontacts/h$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/pickercontacts/h$a;-><init>(Lchat/ola/vn/pickercontacts/h;)V

    return-void
.end method


# virtual methods
.method protected performFiltering(Ljava/lang/CharSequence;)Landroid/widget/Filter$FilterResults;
    .locals 10

    new-instance v0, Landroid/widget/Filter$FilterResults;

    invoke-direct {v0}, Landroid/widget/Filter$FilterResults;-><init>()V

    :try_start_0
    new-instance v1, Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    if-eqz p1, :cond_5

    invoke-interface {p1}, Ljava/lang/CharSequence;->length()I

    move-result v3

    if-lez v3, :cond_5

    iget-object v3, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    const/4 v4, 0x1

    invoke-static {v3, v4}, Lchat/ola/vn/pickercontacts/h;->a(Lchat/ola/vn/pickercontacts/h;Z)Z

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    iget-object v3, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    invoke-static {v3}, Lchat/ola/vn/pickercontacts/h;->a(Lchat/ola/vn/pickercontacts/h;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_1

    iget-object v5, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    invoke-static {v5}, Lchat/ola/vn/pickercontacts/h;->a(Lchat/ola/vn/pickercontacts/h;)Ljava/util/List;

    move-result-object v5

    invoke-interface {v5, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/pickercontacts/c;

    invoke-virtual {v5}, Lchat/ola/vn/pickercontacts/c;->a()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_0

    iget-object v5, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    invoke-static {v5}, Lchat/ola/vn/pickercontacts/h;->a(Lchat/ola/vn/pickercontacts/h;)Ljava/util/List;

    move-result-object v5

    invoke-interface {v5, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-interface {v1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_1
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    if-nez v3, :cond_4

    iget-object v3, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    invoke-static {v3}, Lchat/ola/vn/pickercontacts/h;->a(Lchat/ola/vn/pickercontacts/h;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    const/4 v4, 0x0

    :goto_1
    if-ge v4, v3, :cond_4

    iget-object v5, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    invoke-static {v5}, Lchat/ola/vn/pickercontacts/h;->a(Lchat/ola/vn/pickercontacts/h;)Ljava/util/List;

    move-result-object v5

    invoke-interface {v5, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/pickercontacts/c;

    invoke-virtual {v5}, Lchat/ola/vn/pickercontacts/c;->b()Ljava/util/List;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v5

    const/4 v6, 0x0

    :goto_2
    if-ge v6, v5, :cond_3

    iget-object v7, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    invoke-static {v7}, Lchat/ola/vn/pickercontacts/h;->a(Lchat/ola/vn/pickercontacts/h;)Ljava/util/List;

    move-result-object v7

    invoke-interface {v7, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Lchat/ola/vn/pickercontacts/c;

    invoke-virtual {v7}, Lchat/ola/vn/pickercontacts/c;->b()Ljava/util/List;

    move-result-object v7

    invoke-interface {v7, v6}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/String;

    invoke-static {v7}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v7

    const-string v8, " "

    const-string v9, ""

    invoke-virtual {v7, v8, v9}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "-"

    const-string v9, ""

    invoke-virtual {v7, v8, v9}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7, p1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-eqz v7, :cond_2

    iget-object v5, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    invoke-static {v5}, Lchat/ola/vn/pickercontacts/h;->a(Lchat/ola/vn/pickercontacts/h;)Ljava/util/List;

    move-result-object v5

    invoke-interface {v5, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-interface {v1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_2
    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    :cond_3
    :goto_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :cond_4
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result p1

    iput p1, v0, Landroid/widget/Filter$FilterResults;->count:I

    iput-object v1, v0, Landroid/widget/Filter$FilterResults;->values:Ljava/lang/Object;

    return-object v0

    :cond_5
    monitor-enter p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    invoke-static {p1, v2}, Lchat/ola/vn/pickercontacts/h;->a(Lchat/ola/vn/pickercontacts/h;Z)Z

    iget-object p1, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    iget-object v1, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    invoke-static {v1}, Lchat/ola/vn/pickercontacts/h;->a(Lchat/ola/vn/pickercontacts/h;)Ljava/util/List;

    move-result-object v1

    invoke-static {p1, v1}, Lchat/ola/vn/pickercontacts/h;->a(Lchat/ola/vn/pickercontacts/h;Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    iput v1, v0, Landroid/widget/Filter$FilterResults;->count:I

    iput-object p1, v0, Landroid/widget/Filter$FilterResults;->values:Ljava/lang/Object;

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw p1
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-object v0
.end method

.method protected publishResults(Ljava/lang/CharSequence;Landroid/widget/Filter$FilterResults;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    iget-object p2, p2, Landroid/widget/Filter$FilterResults;->values:Ljava/lang/Object;

    check-cast p2, Ljava/util/List;

    invoke-static {p1, p2}, Lchat/ola/vn/pickercontacts/h;->b(Lchat/ola/vn/pickercontacts/h;Ljava/util/List;)Ljava/util/List;

    iget-object p1, p0, Lchat/ola/vn/pickercontacts/h$a;->a:Lchat/ola/vn/pickercontacts/h;

    invoke-virtual {p1}, Lchat/ola/vn/pickercontacts/h;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
